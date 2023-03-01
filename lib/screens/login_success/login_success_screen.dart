import 'package:flutter/material.dart';
import 'package:tour_around/screens/login_success/components/body_login_success.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  static String routeName = "/login_success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text("Login Successful"),
      ),
      body: const BodyLoginSuccess(),
    );
  }
}
