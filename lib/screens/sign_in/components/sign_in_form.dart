import 'package:flutter/material.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
import 'package:tour_around/screens/sign_up/utils/show_snack_bar.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants/errors.dart';
import '../../../constants/size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String email;
  late String password;
  bool remember = false;
  bool _isLoading = false;
  bool _eyeClosed = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() async {
    setState(() {
      _isLoading = true;
    });
    String response = await AuthMethods().signInUser(
        email: _emailController.text, password: _passwordController.text);
    String response2 =
        await AuthMethods().signInUserLocal(email: email, password: password);

    if (response == "success") {
      Future.delayed(Duration.zero).then(
        (value) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginSuccessScreen(),
          ),
        ),
      );
    } else {
      Future.delayed(Duration.zero).then((value) {
        showSnackBar(response, context);
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  activeColor: tPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.white),
                    ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // if all are valid then go to success
                  signInUser();
                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                }
              }),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _eyeClosed ? false : true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(tPassNullError)) {
          removeError(error: tPassNullError);
        } else if (value.length >= 8 && errors.contains(tShortPassError)) {
          removeError(error: tPassNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(tPassNullError)) {
          addError(error: tPassNullError);
          return "";
        } else if (value.length < 8 && !errors.contains(tShortPassError)) {
          addError(error: tShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          normalIcon: _eyeClosed
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.visibility_off),
          onTap: () {
            setState(() {
              _eyeClosed = !_eyeClosed;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty && !errors.contains(tEmailNullError)) {
          addError(error: tEmailNullError);
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(tInvalidEmailError)) {
          addError(error: tInvalidEmailError);
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(tEmailNullError)) {
          removeError(error: tEmailNullError);
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            errors.contains(tInvalidEmailError)) {
          removeError(error: tInvalidEmailError);
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
    );
  }
}
