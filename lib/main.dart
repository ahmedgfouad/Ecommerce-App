import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/utils/router.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffE5E5E5),
          primaryColor: Colors.red,
          appBarTheme: AppBarTheme(elevation: 2),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: Theme.of(context).textTheme.labelMedium,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        initialRoute: AppRoutes.landingPageRoute,
        onGenerateRoute: onGenerate,
      ),
    );
  }
}
