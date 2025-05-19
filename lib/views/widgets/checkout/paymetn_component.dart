import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';

class PaymetnComponent extends StatelessWidget {
  const PaymetnComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.network(
            AppAssets.masterCardIcon,
            fit: BoxFit.cover,
            height: 50,
          ),
        ),
        const SizedBox(width: 20),
        Text("**** **** **** 3245"),
      ],
    );
  }
}
