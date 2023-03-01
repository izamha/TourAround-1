import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/size_config.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key? key, required this.socialIcon, required this.onPress})
      : super(key: key);

  final String socialIcon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
        ),
        padding: EdgeInsets.all(
          getProportionateScreenWidth(12),
        ),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(socialIcon),
      ),
    );
  }
}
