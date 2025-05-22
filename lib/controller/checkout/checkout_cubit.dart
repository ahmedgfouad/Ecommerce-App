import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImp();

  Future<void> addCard(PaymentMethod paymentMethod) async {
    emit(AddingCards());
    try {
      await checkoutServices.setPaymentMethod(paymentMethod);
      emit(CardsAdded());
    } catch (e) {
      emit(CardsAddingfailed(e.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethod paymentMethod) async {
    emit(DeletingCards(paymentMethod.id));
    try {
      await checkoutServices.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
      fetchCards();
    } catch (e) {
      emit(CardsDeletingfailed(e.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());
    try {
      final paymentMethods = await checkoutServices.paymentMethods();
      emit(CardsFetched(paymentMethods));
    } catch (e) {
      emit(CardsFetchingingfailed(e.toString()));
    }
  }

  Future<void> makePreferred(PaymentMethod paymentMethod) async {
    emit(FetchingCards());
    try {
      final preferredPaymentMethods = await checkoutServices.paymentMethods(
        true,
      );
      for (var method in preferredPaymentMethods) {
        final newPaymentMethod = method.copyWith(isPreferred: false);
        await checkoutServices.setPaymentMethod(newPaymentMethod);
      }
      final newPreferredMethod = paymentMethod.copyWith(isPreferred: true);
      await checkoutServices.setPaymentMethod(newPreferredMethod);
      emit(PreferredMade());
      fetchCards();
    } catch (e) {
      emit(PreferredMakingFailed(e.toString()));
    }
  }
}
