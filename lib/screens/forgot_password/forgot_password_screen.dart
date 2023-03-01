import 'package:flutter/material.dart';
import 'package:tour_around/screens/forgot_password/components/body_forgot_password.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static String routeName = "/forgot_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Forgot Password"),
      ),
      body: const BodyForgotPassword(),
    );
  }
}
