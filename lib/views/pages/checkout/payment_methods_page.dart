import 'package:ecommerce/controller/checkout/checkout_cubit.dart';
import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/views/widgets/checkout/add_new_card_bottom_shet.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    Future<void> showBottomShet({PaymentMethod? paymentMethod}) async {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return BlocProvider.value(
            value: checkoutCubit,
            child: AddNewCardBottomShet(paymentMethod: paymentMethod),
          );
        },
      ).then((value) => checkoutCubit.fetchCards());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Payment Methods"), centerTitle: true),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        bloc: checkoutCubit,
        listenWhen:
            (previous, current) =>
                current is PreferredMade || current is PreferredMakingFailed,
        listener: (context, state) {
          if (state is PreferredMade) {
            Navigator.of(context).pop();
          } else if (state is PreferredMakingFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        buildWhen:
            (previous, current) =>
                current is FetchingCards ||
                current is CardsFetched ||
                current is CardsFetchingingfailed,
        builder: (context, state) {
          if (state is FetchingCards) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CardsFetchingingfailed) {
            return Center(child: Text(state.error));
          } else if (state is CardsFetched) {
            final paymentMethods = state.paymentMethods;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Payment Carts",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        final paymentmethod = paymentMethods[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: InkWell(
                            onTap: () async {
                              await checkoutCubit.makePreferred(paymentmethod);
                            },
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.credit_card),
                                        SizedBox(width: 10),
                                        Text(paymentmethod.cardNumber),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showBottomShet(
                                            paymentMethod: paymentmethod,
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      BlocBuilder<CheckoutCubit, CheckoutState>(
                                        bloc: CheckoutCubit(),
                                        buildWhen:
                                            (previous, current) =>
                                                (current is DeletingCards &&
                                                    current.paymentId ==
                                                        paymentmethod.id) ||
                                                current is CardsDeleted ||
                                                current is CardsDeletingfailed,

                                        builder: (context, state) {
                                          if (state is DeletingCards) {
                                            return const CircularProgressIndicator.adaptive();
                                          }
                                          return IconButton(
                                            onPressed: () async {
                                              await checkoutCubit.deleteCard(
                                                paymentmethod,
                                              );
                                            },
                                            icon: const Icon(Icons.delete),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    MainButton(
                      hasCirclarBorder: true,
                      onTap: () {
                        showBottomShet();
                      },
                      text: "Add New Card",
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
