import 'package:flutter/material.dart';
import 'package:tour_around/screens/category/category_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants/size_config.dart';
import '../../home/home_screen.dart';

class BodyLoginSuccess extends StatelessWidget {
  const BodyLoginSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight! * 0.04,
        ),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight! * 0.4,
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * 0.08,
        ),
        Text(
          "Successful Login",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            child: Text(
              "Head Home",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white),
            ),
            onPressed: () => Navigator.pushNamed(context, CategoryScreen.routeName),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
