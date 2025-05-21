import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/shipping_addressl.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressComponent extends StatelessWidget {
  const ShippingAddressComponent({super.key, required this.shippingAddress});
  final ShippingAddress shippingAddress;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap:
                      () => Navigator.of(context).pushNamed(
                        AppRoutes.shippingAddresRoute,
                        arguments: database,
                      ),
                  child: Text(
                    "Change",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "${shippingAddress.city}, ${shippingAddress.state},${shippingAddress.country}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
