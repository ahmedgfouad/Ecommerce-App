import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/shipping_addressl.dart';
import 'package:ecommerce/utils/args_models.dart/add_shipping_addres_argsl.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingAddressStateItem extends StatefulWidget {
  const ShippingAddressStateItem({super.key, required this.shippingAddress});
  final ShippingAddress shippingAddress;

  @override
  State<ShippingAddressStateItem> createState() =>
      _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late bool checkedValue;
  @override
  void initState() {
    super.initState();
    checkedValue = widget.shippingAddress.isDefault;
  }

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
                  widget.shippingAddress.fullName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap:
                      () => Navigator.of(context).pushNamed(
                        AppRoutes.addShippingAddresRoute,
                        arguments: AddShippingAddresArgs(
                          database: database,
                          shippingAddress: widget.shippingAddress,
                        ),
                      ),
                  child: Text(
                    "Edit",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "${widget.shippingAddress.city}, ${widget.shippingAddress.state},${widget.shippingAddress.country}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8.0),
            CheckboxListTile(
              title: const Text("Dsefalut shipping address"),
              value: checkedValue,
              onChanged: (nweValue) async {
                setState(() {
                  checkedValue = nweValue!;
                });
                final newAddress = widget.shippingAddress.copyWith(
                  isDefault: nweValue,
                );
                await database.saveAddress(newAddress);
              },
              activeColor: Colors.redAccent,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
