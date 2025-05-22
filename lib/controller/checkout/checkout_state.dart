part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class AddingCards extends CheckoutState {}

final class CardsAdded extends CheckoutState {}

final class CardsAddingfailed extends CheckoutState {
  final String error;
  CardsAddingfailed(this.error);
}

final class FetchingCards extends CheckoutState {}

final class CardsFetched extends CheckoutState {
  final List<PaymentMethod> paymentMethods;
  CardsFetched(this.paymentMethods);
}

final class CardsFetchingingfailed extends CheckoutState {
  final String error;
  CardsFetchingingfailed(this.error);
}


final class DeletingCards extends CheckoutState {}

final class CardsDeleted extends CheckoutState {}

final class CardsDeletingfailed extends CheckoutState {
  final String error;
  CardsDeletingfailed(this.error);
}
