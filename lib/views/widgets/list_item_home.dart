import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ListItemHome extends StatelessWidget {
  const ListItemHome({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    height: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          '${product.discountValue}%',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              product.category,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${product.price}\$  ",
                    style: Theme.of(context).textTheme.bodySmall!
                        .copyWith(color: Colors.grey)
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  TextSpan(
                    text: ' ${product.price * (product.discountValue) / 100}\$',
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
