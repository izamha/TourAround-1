import 'package:flutter/material.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../components/have_no_account_text.dart';
import '../../../constants/errors.dart';
import '../../../constants/size_config.dart';

class BodyForgotPassword extends StatelessWidget {
  const BodyForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * 0.04,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "Please enter your email and we will send \nyou a link to return to your account.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.1,
              ),
              const ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  List<String> errors = [];
  late String email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty && !errors.contains(tEmailNullError)) {
                errors.add(tEmailNullError);
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(tInvalidEmailError)) {
                errors.add(tInvalidEmailError);
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(tEmailNullError)) {
                errors.remove(tEmailNullError);
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(tInvalidEmailError)) {
                errors.remove(tInvalidEmailError);
              }
            },
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue!,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(
                svgIcon: "assets/icons/mail.svg",
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          FormError(errors: errors),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          DefaultButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Say something
                }
              }),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.1,
          ),
          const HaveNoAccountText(),
        ],
      ),
    );
  }
}
