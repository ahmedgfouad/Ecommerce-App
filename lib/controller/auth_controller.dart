import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/utils/enum.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFormType;

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  Future<void> submit() async {
    debugPrint(authFormType.toString());
    try {
      if (authFormType == AuthFormType.login) {
        await auth.lgoinWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  void toggleFormTypy() {
    final formType =
        authFormType == AuthFormType.login
            ? AuthFormType.register
            : AuthFormType.login;
    copyWith(email: '', password: '', authFormType: formType);
  }

  void updateEmain(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);

  void copyWith({String? email, String? password, AuthFormType? authFormType}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }
}
