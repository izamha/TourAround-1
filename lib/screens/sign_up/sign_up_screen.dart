import 'package:flutter/material.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/sign_up/components/body_sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: SafeArea(
        child: BodySignUp(),
      ),
    );
  }
}
