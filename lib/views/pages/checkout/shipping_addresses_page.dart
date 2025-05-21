import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/shipping_addressl.dart';
import 'package:ecommerce/utils/args_models.dart/add_shipping_addres_argsl.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/widgets/checkout/shipping_address_state_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Shipping Address",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<ShippingAddress>>(
            stream: database.getShaippingAddress(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final shippingAddresses = snapshot.data;

                return Column(
                  children:
                      shippingAddresses!
                          .map(
                            (shippingAddress) => ShippingAddressStateItem(
                              shippingAddress: shippingAddress,
                            ),
                          )
                          .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator.adaptive());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.addShippingAddresRoute, arguments:AddShippingAddresArgs(database: database) ),
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
