import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/shipping_addressl.dart';

class AddShippingAddresArgs {
  final Database database;
  final ShippingAddress? shippingAddress;

  AddShippingAddresArgs({
    required this.database,
     this.shippingAddress,
  });
}
