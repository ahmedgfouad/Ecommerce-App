import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/delivery_method.dart';
import 'package:ecommerce/models/shipping_addressl.dart';
import 'package:ecommerce/utils/args_models.dart/add_shipping_addres_argsl.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/widgets/checkout/checkout_order_details.dart';
import 'package:ecommerce/views/widgets/checkout/delivary_method_item.dart';
import 'package:ecommerce/views/widgets/checkout/paymetn_component.dart';
import 'package:ecommerce/views/widgets/checkout/shipping_address_component.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shipping addres",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 6),
              StreamBuilder<List<ShippingAddress>>(
                stream: database.getShaippingAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final shippingAddresses = snapshot.data;
                    if (shippingAddresses == null ||
                        shippingAddresses.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Text("No shipping addresses!!"),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.addShippingAddresRoute,
                                  arguments: AddShippingAddresArgs(
                                    database: database,
                                  ),
                                );
                              },
                              child: Text(
                                'Add new one',
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    final shippingAddress = shippingAddresses.first;
                    return ShippingAddressComponent(
                      shippingAddress: shippingAddress,
                    );
                  }
                  return Center(child: CircularProgressIndicator.adaptive());
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment", style: Theme.of(context).textTheme.bodyLarge),
                  InkWell(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.paymentMethodsRoute);
                    },
                    child: Text(
                      "Change",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              PaymetnComponent(),
              const SizedBox(height: 10),
              Text(
                "Delivery metho",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              StreamBuilder<List<DeliveryMethod>>(
                stream: database.deliveryMethodsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final deliveryMethods = snapshot.data;
                    if (deliveryMethods == null || deliveryMethods.isEmpty) {
                      return const Center(
                        child: Text("No delivery methods avaliable!!"),
                      );
                    }
                    return SizedBox(
                      height: size.height * .12,
                      child: ListView.builder(
                        itemCount: deliveryMethods.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, i) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: DelivaryMethodItem(
                                deliveryMethod: deliveryMethods[i],
                              ),
                            ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator.adaptive());
                },
              ),
              const SizedBox(height: 5),
              CheckoutOrderDetails(),
              const SizedBox(height: 20),
              MainButton(
                text: "Submit Order",
                onTap: () {},
                hasCirclarBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
