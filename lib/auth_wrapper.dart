import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'signup.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          SignInScreen(),
          SignUpScreen(),
        ],
      ),
    );
  }
}