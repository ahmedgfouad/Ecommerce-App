import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListItemHome extends StatefulWidget {
  const ListItemHome({super.key, required this.product});
  final Product product;

  @override
  State<ListItemHome> createState() => _ListItemHomeState();
}

class _ListItemHomeState extends State<ListItemHome> {
  final bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap:
          () => Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(AppRoutes.productDetailsRoute, arguments: widget.product),
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.product.imageUrl,
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
                            '${widget.product.discountValue}%',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                left: size.width * .33,
                height: size.height * .4,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 13,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          itemSize: 20,
                          rating: widget.product.rate?.toDouble() ?? 0.0,
                          direction: Axis.horizontal,
                          itemBuilder:
                              (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                        ),
                        Text(
                          "(100)",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.product.category,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.grey),
                    ),
                    Text(
                      widget.product.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${widget.product.price}\$  ",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.grey)
                                .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                          TextSpan(
                            text:
                                ' ${widget.product.price * (widget.product.discountValue) / 100}\$',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
