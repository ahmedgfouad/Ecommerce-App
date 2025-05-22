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

final class DeletingCards extends CheckoutState {
  final String paymentId;

  DeletingCards(this.paymentId);
}

final class CardsDeleted extends CheckoutState {}

final class CardsDeletingfailed extends CheckoutState {
  final String error;
  CardsDeletingfailed(this.error);
}

final class MakingPreferred extends CheckoutState {}

final class PreferredMade extends CheckoutState {}

final class PreferredMakingFailed extends CheckoutState {
  final String error;

  PreferredMakingFailed(this.error);
}
