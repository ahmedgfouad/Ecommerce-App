import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({super.key, required this.cartItem});

  final AddToCartModel cartItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.network(cartItem.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.title),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Color: ',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            TextSpan(
                              text: cartItem.color,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Size: ',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            TextSpan(
                              text: cartItem.size,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Icon(Icons.more_vert),
                  Text(
                    "${cartItem.price} \$",
                    style: Theme.of(context).textTheme.bodyLarge,
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
