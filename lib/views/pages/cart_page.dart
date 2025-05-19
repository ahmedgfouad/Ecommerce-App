import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/widgets/cart_list_item.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/order_sumary_componant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAmount = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final myProducts =
        await Provider.of<Database>(
          context,
          listen: false,
        ).myProductsCart().first;
    myProducts.forEach((element) {
      setState(() {
        totalAmount += element.price;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
        stream: database.myProductsCart(),
        builder: (context, snapshot) {
          final cartItems = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "My Cart",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (cartItems == null || cartItems.isEmpty)
                      Center(child: Text("No Data Available!!")),
                    if (cartItems != null && cartItems.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, i) {
                          final cartItem = cartItems[i];
                          return CartListItem(cartItem: cartItem);
                        },
                      ),
                    const SizedBox(height: 30),
                    OrderSumaryComponent(
                      title: "Total Amount",
                      value: totalAmount.toString(),
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      text: "Check Out",
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.checkoutRoute,
                          arguments: database,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
