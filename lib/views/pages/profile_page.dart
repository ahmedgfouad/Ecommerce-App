import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // ignore: unused_element
  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
    } catch (e) {
      debugPrint("logout errer :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MainButton(
              text: "Log Out",
              onTap: () {
                // _logout(value, context);
              },
            ),
          ),
        ],
      
    );
  }
}
