// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/utils/enum.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      // Navigator.of(context).pushNamed(AppRoutes.bottomNavBarRoute);
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(
                "Error !",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              content: Text(
                e.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder:
          (_, model, __) => Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 32,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.authFormType == AuthFormType.login
                              ? "Login"
                              : "Register",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          onChanged: model.updateEmain,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete:
                              () => FocusScope.of(
                                context,
                              ).requestFocus(_passwordFocusNode),
                          validator:
                              (val) =>
                                  val!.isEmpty
                                      ? "plese enter your email "
                                      : null,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: "Enter your email",
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: model.updatePassword,
                          focusNode: _passwordFocusNode,
                          validator:
                              (val) =>
                                  val!.isEmpty
                                      ? "plese enter your password "
                                      : null,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'password',
                            hintText: "Enter your password",
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        if (model.authFormType == AuthFormType.login)
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: const Text("Forget your password"),
                            ),
                          ),
                        const SizedBox(height: 25.0),
                        MainButton(
                          text:
                              model.authFormType == AuthFormType.login
                                  ? "Login"
                                  : "Register",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _submit(model);
                            }
                          },
                        ),
                        const SizedBox(height: 10.0),

                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text(
                              model.authFormType == AuthFormType.login
                                  ? "Don't have an account? Register"
                                  : "Have account Login",
                            ),
                            onTap: () {
                              _formKey.currentState!.reset();
                              model.toggleFormTypy();
                            },
                          ),
                        ),
                        SizedBox(height: size.height / 9),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            model.authFormType == AuthFormType.login
                                ? "Or Login with"
                                : "Or register with",
                          ),
                        ),
                        const SizedBox(height: 10.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(Icons.facebook_sharp),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(Icons.facebook),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
