import 'package:ecommerce/models/delivery_method.dart';
import 'package:flutter/material.dart';

class DelivaryMethodItem extends StatelessWidget {
  const DelivaryMethodItem({super.key, required this.deliveryMethod});
  final DeliveryMethod deliveryMethod;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              deliveryMethod.imageUrl,
              fit: BoxFit.cover,
              height: 30,
            ),
            const SizedBox(height: 8),
            Text(
              deliveryMethod.days,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
