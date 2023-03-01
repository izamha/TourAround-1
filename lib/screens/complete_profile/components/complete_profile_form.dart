import 'package:flutter/material.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants/errors.dart';
import '../../../constants/size_config.dart';
import '../../otp/otp_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;

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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            buildFirstNameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            buildLastNameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            buildPhoneNumberFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            DefaultButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Go to OTP screen
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            }),
          ],
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tAddressNullError);
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: tAddressNullError);
        }
      },
      onSaved: (newValue) => address = newValue!,
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/location-point.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tPhoneNumberNullError);
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: tPhoneNumberNullError);
        }
      },
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue!,
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/phone.svg",
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => lastName = newValue!,
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/user.svg",
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: tNamelNullError);
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: tNamelNullError);
        }
      },
      keyboardType: TextInputType.name,
      onSaved: (newValue) => firstName = newValue!,
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/user.svg",
        ),
      ),
    );
  }
}
