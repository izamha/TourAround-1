import 'package:flutter/material.dart';
import 'package:tour_around/screens/sign_in/components/sign_in_form.dart';
import '../../../components/have_no_account_text.dart';
import '../../../constants/size_config.dart';
import '../../sign_up/components/social_card.dart';

class BodySignIn extends StatelessWidget {
  const BodySignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.04,
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign in with your email and password \nor continue with social media.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.08,
                ),
                const SignInForm(),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      socialIcon: "assets/icons/google-icon.svg",
                      onPress: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                const HaveNoAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
