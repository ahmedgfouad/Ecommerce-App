import 'package:ecommerce/controller/checkout/checkout_cubit.dart';
import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/utils/constant.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardBottomShet extends StatefulWidget {
  const AddNewCardBottomShet({super.key});

  @override
  State<AddNewCardBottomShet> createState() => _AddNewCardBottomShetState();
}

class _AddNewCardBottomShetState extends State<AddNewCardBottomShet> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameOnCardController,
      _cardNumberController,
      _expireDateController,
      _cvvController;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameOnCardController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expireDateController = TextEditingController();
    _cvvController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return SizedBox(
      height: size.height * 2,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Add New Card",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nameOnCardController,
                validator:
                    (value) =>
                        value != null && value.isEmpty
                            ? "Please enter your name"
                            : null,
                decoration: InputDecoration(
                  labelText: "Name On Card",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _cardNumberController,
                onChanged: (value) {
                  String newValue = value.replaceAll('-', '');
                  if (newValue.length % 4 == 0 && newValue.length < 16) {
                    _cardNumberController.text += '-';
                  }
                  if (value.length >= 20) {
                    _cardNumberController.text = value.substring(0, 19);
                  }
                },
                validator:
                    (value) =>
                        value != null && value.isEmpty
                            ? "Please enter your card number"
                            : null,
                decoration: InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: _expireDateController,
                onChanged: (value) {
                  if (value.length == 2 && !value.contains('/')) {
                    _expireDateController.text += '/';
                  }
                  if (value.length >= 5) {
                    _expireDateController.text = value.substring(0, 5);
                  }
                },
                validator:
                    (value) =>
                        value != null && value.isEmpty
                            ? "Please enter your expire date"
                            : null,
                decoration: InputDecoration(
                  labelText: "Expire Date",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _cvvController,
                onChanged: (value) {
                  if (value.length >= 3) {
                    _cvvController.text = value.substring(0, 3);
                  }
                },
                validator:
                    (value) =>
                        value != null && value.isEmpty
                            ? "Please enter your cvv"
                            : null,
                decoration: InputDecoration(
                  labelText: "CVV",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<CheckoutCubit, CheckoutState>(
                bloc: checkoutCubit,
                listenWhen:
                    (previous, current) =>
                        current is CardsAdded || current is CardsAddingfailed,
                listener: (context, state) {
                  if (state is CardsAdded) {
                    Navigator.of(context).pop();
                  } else if (state is CardsAddingfailed) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                buildWhen:
                    (previous, current) =>
                        current is AddingCards ||
                        current is CardsAdded ||
                        current is CardsAddingfailed,
                builder: (context, state) {
                  if (state is AddingCards) {
                    return MainButton(
                      onTap: null,
                      child: const CircularProgressIndicator.adaptive(),
                    );
                  }

                  return MainButton(
                    text: "Add Card",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final paymentMethod = PaymentMethod(
                          id: documentIdFromLocalData(),
                          name: _nameOnCardController.text,
                          cardNumber: _cardNumberController.text,
                          expiryDate: _expireDateController.text,
                          cvv: _cvvController.text,
                        );
                        await checkoutCubit.addCard(paymentMethod);
                      }
                    },
                    hasCirclarBorder: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
