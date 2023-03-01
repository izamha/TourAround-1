import 'package:flutter/material.dart';
import 'package:tour_around/screens/splash/components/body_splash.dart';

import '../../constants/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: BodySplash(),
    );
  }
}
