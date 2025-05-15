import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/pages/landing_page.dart';
import 'package:ecommerce/views/pages/auth_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerate(RouteSettings setting) {
  switch (setting.name) {
    case AppRoutes.authPageRoute:
      return MaterialPageRoute(builder: (_) => AuthPage());
    case AppRoutes.landingPageRoute:
      return MaterialPageRoute(builder: (_) => LandingPage());

    default:
      return MaterialPageRoute(builder: (_) => LandingPage());
  }
}
