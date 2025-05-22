import 'package:ecommerce/controller/checkout/checkout_cubit.dart';
import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/utils/args_models.dart/add_shipping_addres_argsl.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/pages/bottom_nav_bar.dart';
import 'package:ecommerce/views/pages/checkout/add_shipping_addresses_page.dart';
import 'package:ecommerce/views/pages/checkout/checkout_page.dart';
import 'package:ecommerce/views/pages/checkout/payment_methods_page.dart';
import 'package:ecommerce/views/pages/checkout/shipping_addresses_page.dart';
import 'package:ecommerce/views/pages/landing_page.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:ecommerce/views/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Route<dynamic> onGenerate(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.authPageRoute:
      return MaterialPageRoute(
        builder: (_) => const AuthPage(),
        settings: setting,
      );

    case AppRoutes.landingPageRoute:
      return MaterialPageRoute(
        builder: (_) => const LandingPage(),
        settings: setting,
      );
    case AppRoutes.bottomNavBarRoute:
      return MaterialPageRoute(
        builder: (_) => const BottomNavBarPage(),
        settings: setting,
      );
    case AppRoutes.productDetailsRoute:
      final args = setting.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return MaterialPageRoute(
        builder:
            (_) => Provider<Database>.value(
              value: database,
              child: ProductDetails(product: product),
            ),
        settings: setting,
      );

    case AppRoutes.checkoutRoute:
      final database = setting.arguments as Database;
      return MaterialPageRoute(
        builder:
            (_) => Provider<Database>.value(
              value: database,
              child: const CheckoutPage(),
            ),
        settings: setting,
      );
    case AppRoutes.shippingAddresRoute:
      final database = setting.arguments as Database;
      return MaterialPageRoute(
        builder:
            (_) => Provider<Database>.value(
              value: database,
              child: const ShippingAddressesPage(),
            ),
        settings: setting,
      );
    case AppRoutes.addShippingAddresRoute:
      final args = setting.arguments as AddShippingAddresArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;
      return MaterialPageRoute(
        builder:
            (_) => Provider<Database>.value(
              value: database,
              child: AddShippingAddressesPage(shippingAddress: shippingAddress),
            ),
        settings: setting,
      );
    case AppRoutes.paymentMethodsRoute:
      return MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (context) {
                final cubit = CheckoutCubit();
                cubit.fetchCards();
                return cubit;
              },
              child: const PaymentMethodsPage(),
            ),
        settings: setting,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const LandingPage(),
        settings: setting,
      );
  }
}
