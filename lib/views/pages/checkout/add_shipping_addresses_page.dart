import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/shipping_addressl.dart';
import 'package:ecommerce/utils/constant.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddShippingAddressesPage extends StatefulWidget {
  final ShippingAddress? shippingAddress;
  const AddShippingAddressesPage({super.key, this.shippingAddress});

  @override
  State<AddShippingAddressesPage> createState() =>
      _AddShippingAddressesPageState();
}

class _AddShippingAddressesPageState extends State<AddShippingAddressesPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();

  ShippingAddress? shippingAddress;
  @override
  void initState() {
    super.initState();
    shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      _fullNameController.text = shippingAddress!.fullName;
      _addressController.text = shippingAddress!.address;
      _cityController.text = shippingAddress!.city;
      _stateController.text = shippingAddress!.state;
      _zipCodeController.text = shippingAddress!.zipCode;
      _countryController.text = shippingAddress!.country;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> saveAddress(Database database) async {
    try {
      if (_formKey.currentState!.validate()) {
        final address = ShippingAddress(
          id:
              shippingAddress != null
                  ? shippingAddress!.id
                  : documentIdFromLocalData(),
          fullName: _fullNameController.text.trim(),
          country: _countryController.text.trim(),
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          zipCode: _zipCodeController.text.trim(),
        );
        await database.saveAddress(address);
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      mainShowdialog(e: e.toString(), context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          shippingAddress != null
              ? "Editing Shipping Address"
              : "Adding Shipping Address",
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
            child: Column(
              children: [
                TextFormField(
                  validator:
                      (value) =>
                          value!.isNotEmpty ? null : "pleade enter your name",
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    label: Text("Full Name"),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator:
                      (value) =>
                          value!.isNotEmpty
                              ? null
                              : "pleade enter your address",
                  controller: _addressController,
                  decoration: const InputDecoration(
                    label: Text("Address"),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator:
                      (value) =>
                          value!.isNotEmpty ? null : "pleade enter your city",
                  controller: _cityController,
                  decoration: const InputDecoration(
                    label: Text("City"),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator:
                      (value) =>
                          value!.isNotEmpty ? null : "pleade enter your state",
                  controller: _stateController,
                  decoration: const InputDecoration(
                    label: Text("State / province"),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator:
                      (value) =>
                          value!.isNotEmpty
                              ? null
                              : "pleade enter your zip code",
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    label: Text("Zip Code"),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator:
                      (value) =>
                          value!.isNotEmpty
                              ? null
                              : "pleade enter your country",
                  controller: _countryController,
                  decoration: const InputDecoration(
                    label: Text("Contry"),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 30),
                MainButton(
                  text: "Save Address",
                  onTap: () => saveAddress(database),
                  hasCirclarBorder: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
