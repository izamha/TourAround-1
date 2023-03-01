import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.child = const Text(
        "Continue",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      required this.onPressed})
      : super(key: key);
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF00EDA7)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
