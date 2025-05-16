import 'package:ecommerce/utils/enum.dart';
import 'package:ecommerce/utils/routes.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

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

  var _authType = AuthFormType.login;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _authType == AuthFormType.login ? "Login" : "Register",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete:
                        () => FocusScope.of(
                          context,
                        ).requestFocus(_passwordFocusNode),
                    validator:
                        (val) =>
                            val!.isEmpty ? "plese enter your email " : null,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: "Enter your email",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    validator:
                        (val) =>
                            val!.isEmpty ? "plese enter your password " : null,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'password',
                      hintText: "Enter your password",
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  if (_authType == AuthFormType.login)
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
                        _authType == AuthFormType.login ? "Login" : "Register",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.bottomNavBarRoute);
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        _formKey.currentState!.reset();

                        setState(() {
                          if (_authType == AuthFormType.login) {
                            _authType = AuthFormType.register;
                          } else {
                            _authType = AuthFormType.login;
                          }
                        });
                      },
                      child: Text(
                        _authType == AuthFormType.login
                            ? "Don't have an account? Register"
                            : "Have account Login",
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 9),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _authType == AuthFormType.login
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
    );
  }
}
