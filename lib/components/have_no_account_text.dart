import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/size_config.dart';
import '../screens/sign_up/sign_up_screen.dart';

class HaveNoAccountText extends StatelessWidget {
  const HaveNoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: tPrimaryColor),
          ),
        ),
      ],
    );
  }
}
