import 'package:ecommerce/views/pages/cart_page.dart';
import 'package:ecommerce/views/pages/home_page.dart';
import 'package:ecommerce/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: Container(),
            item: ItemConfig(
              icon: Icon(Icons.shopping_bag_outlined),
              title: "Shop",
            ),
          ),
          PersistentTabConfig(
            screen: CartPage(),
            item: ItemConfig(
              icon: Icon(Icons.shopping_cart_outlined),
              title: "Cart",
            ),
          ),

          PersistentTabConfig(
            screen: Container(),
            item: ItemConfig(
              icon: Icon(Icons.favorite_border),
              title: "Favorites",
            ),
          ),
          PersistentTabConfig(
            screen: ProfilePage(),
            item: ItemConfig(icon: Icon(Icons.person), title: "Profile"),
          ),
        ],
        navBarBuilder:
            (navBarConfig) => Style2BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
