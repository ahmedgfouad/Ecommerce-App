import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/views/widgets/list_item_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                fit: BoxFit.cover,
                AppAssets.topBannerHomePageAssets,
                width: double.infinity,
                height: size.height * .3,
              ),
              Opacity(
                opacity: .2,
                child: Container(
                  width: double.infinity,
                  height: size.height * .3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Text(
                  "Street Clothes",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                BuildHeaderOfList(
                  title: "Sale",
                  description: "Super Summer Sale",
                  onTap: null,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 240,
                  child: StreamBuilder<List<Product>>(
                    stream: database.salesProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final products = snapshot.data;
                        if (products == null || products.isEmpty) {
                          return const Center(
                            child: Text("No Data Available!!"),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(product: products[index]),
                              ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                BuildHeaderOfList(
                  title: "New",
                  description: "Super Summer Sale",
                  onTap: null,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                    stream: database.newProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final products = snapshot.data;
                        if (products == null || products.isEmpty) {
                          return const Center(
                            child: Text("No Data Available!!"),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(product: products[index]),
                              ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildHeaderOfList extends StatelessWidget {
  const BuildHeaderOfList({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                "View All",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
