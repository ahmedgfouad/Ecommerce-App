import 'package:flutter/material.dart';

class AddShippingAddressesPage extends StatefulWidget {
  const AddShippingAddressesPage({super.key});

  @override
  State<AddShippingAddressesPage> createState() => _AddShippingAddressesPageState();
}

class _AddShippingAddressesPageState extends State<AddShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(centerTitle: true, title: Text("Adding Shipping Address")),

      // body: ,
    );
  }
}