import 'package:flutter/material.dart';

class OrderSumaryComponent extends StatelessWidget {
  const OrderSumaryComponent({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
        ),
        Text("$value \$", style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }
}
