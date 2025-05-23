import 'package:ecommerce/controller/database_controller.dart';
import 'package:ecommerce/models/user_data.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/utils/constant.dart';
import 'package:ecommerce/utils/enum.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  AuthFormType authFormType;
  final Database database = FirestoreDatabase('123');

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
        final user = await auth.signUpWithEmailAndPassword(email, password);
        await database.setUserData(
          UserData(
            uid: user?.uid ?? documentIdFromLocalData(),
           email: email,
           ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await auth.logout();
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
