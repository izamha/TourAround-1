import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/screens/sign_in/sign_in_screen.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants/errors.dart';
import '../../../constants/size_config.dart';
import '../../../utils/pick_image.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? _image;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String conformPassword;
  bool remember = false;
  final List<String> errors = [];
  String _selectedUserType = "Normal User";
  bool _eyeClosed = false;
  bool _eyeClosedConfirm = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void _onSelectedItemIndexChange(int newIndex) {
    if (newIndex == 0) {
      _selectedUserType = "Normal User";
    } else {
      _selectedUserType = "Admin";
    }
    debugPrint("UserType: $_selectedUserType");
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String response = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      userType: _selectedUserType,
      file: _image!,
    );

    if (response != "success") {
      Fluttertoast.showToast(
        msg: response,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: tSecondaryColor,
      );
      setState(() {
        _isLoading = false;
      });
      debugPrint("response: $response");
    } else {
      Future.delayed(Duration.zero).then(
        (value) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        ),
      );
    }
    // if (response != "success") {
    //   showSnackBar(response, context);
    // } else {
    // }
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
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      backgroundColor: tPrimaryColor,
                      foregroundColor: tPrimaryColor,
                      radius: 64,
                      backgroundImage: AssetImage("assets/images/user.png"),
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          SizedBox(
            height: getProportionateScreenHeight(50),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListWheelScrollView(
              onSelectedItemChanged: _onSelectedItemIndexChange,
              itemExtent: 40,
              useMagnifier: true,
              clipBehavior: Clip.antiAlias,
              children: const <Widget>[
                Text(
                  "Normal User",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: tSecondaryColor),
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: tSecondaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
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
                signUpUser();
                // if all are valid then go to success screen
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      controller: _usernameController,
      textInputAction: TextInputAction.next,
      obscureText: false,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tNamelNullError);
        } else {
          removeError(error: tNamelNullError);
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Username",
        hintText: "Username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/pen.svg",
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      controller: _confirmPassController,
      textInputAction: TextInputAction.done,
      obscureText: _eyeClosedConfirm ? false : true,
      onSaved: (newValue) => conformPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: tPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: tMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: tMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          normalIcon: _eyeClosedConfirm
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.visibility_off),
          onTap: () {
            setState(() {
              _eyeClosedConfirm = !_eyeClosedConfirm;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      obscureText: _eyeClosed ? false : true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: tPassNullError);
        } else if (value.length >= 8) {
          removeError(error: tShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tPassNullError);
          return "";
        } else if (value.length < 8) {
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
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: tEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: tInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: tInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/mail.svg"),
      ),
    );
  }
}
