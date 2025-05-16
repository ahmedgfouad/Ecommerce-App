import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/pages/bottom_nav_bar.dart';
import 'package:ecommerce/views/pages/landing_page.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:flutter/material.dart';

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

    default:
      return MaterialPageRoute(
        builder: (_) => const LandingPage(),
        settings: setting,
      );
  }
}
