import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

showCustomizableDialog(
  BuildContext context,
  Widget title,
  Widget content,
  String confirmBtnText,
  void Function() onPressed,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: (() => Navigator.pop(context, 'Cancel')),
          child: const Text(
            "Cancel",
            style: TextStyle(color: tPrimaryColor),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            confirmBtnText,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    ),
  );
}
