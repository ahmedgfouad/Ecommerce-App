import 'package:flutter/material.dart';

class ShippingAddressComponent extends StatelessWidget {
  const ShippingAddressComponent({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "Ahmed Gamal",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap: () {},
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
              "13 Mohamed Ali Street",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text("Dokki , Giza", style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
