import 'package:ecommerce/views/widgets/order_sumary_componant.dart';
import 'package:flutter/material.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        OrderSumaryComponent(title: "Order", value: "125 \$"),
        SizedBox(height: 8),
        OrderSumaryComponent(title: "Delivery", value: "15 \$"),
        SizedBox(height: 8), 
        OrderSumaryComponent(title: "Sumary", value: "140 \$"),
      ],
    );
  }
}
