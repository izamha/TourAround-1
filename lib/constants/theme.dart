import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tour_around/constants/colors.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Gordita",
      appBarTheme: appBarTheme(context),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: tTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder);
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: tTextColor),
    bodyText2: TextStyle(color: tTextColor),
  );
}

AppBarTheme appBarTheme(BuildContext context) {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
          fontSize: 18,
          color: const Color(0xFF8B8B8B),
        ),
  );
}

final ButtonStyle flatRoundButtonStyle = TextButton.styleFrom(
    foregroundColor: const Color(0xFFF5F6F9),
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    backgroundColor: Colors.white);

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: tPrimaryColor,
  minimumSize: const Size(88, 60),
  padding: const EdgeInsets.symmetric(horizontal: 20),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  ),
  backgroundColor: const Color(0xFFF5F6F9),
);
