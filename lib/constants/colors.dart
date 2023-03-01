import 'package:flutter/material.dart';

const mobileBackgroundColor = Color.fromARGB(255, 86, 86, 85);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const tPrimaryColor = Color(0xFF1BC794);
const tPrimaryLightColor = Color(0xFFFFECDF);
const tSecondaryColor = Color(0xFF979797);
const tTextColor = Color(0xFF757575);
const tScaffoldBgColor = Color(0xFFFEFBF9); // #F9EEEE

const tPrimaryGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)]);

const tAnimationDuration = Duration(milliseconds: 200);

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
