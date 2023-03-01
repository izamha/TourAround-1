import 'package:flutter/material.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/sign_in/components/body_sign_in.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Sign In"),
      ),
      body: const BodySignIn(),
    );
  }
}
