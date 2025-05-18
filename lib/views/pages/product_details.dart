// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utils/constant.dart';
import 'package:ecommerce/views/widgets/drop_down_menue.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:ecommerce/views/widgets/main_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  late String dropdownValue;
  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        imageUrl: widget.product.imageUrl,
        size: dropdownValue,
        productId: widget.product.id,
      );
      await database.addToCart(addToCartProduct);
    } catch (e) {
      mainShowdialog(e: e, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product.title),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imageUrl,
              width: double.infinity,
              height: size.height * .5,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: DropDownMenuComponant(
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: ['S', 'M', 'L', 'XL', 'XXL'],
                            hint: 'Size',
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color:
                                  isFavorite
                                      ? Colors.redAccent
                                      : Colors.black45,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$ ${widget.product.price}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    widget.product.category,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "This is a dummy Description for this product,we will change it in future .This is a dummy Description for this product,we will change it in future",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  MainButton(
                    text: "Add To Cart",
                    onTap:()=> _addToCart(database),
                    hasCirclarBorder: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
