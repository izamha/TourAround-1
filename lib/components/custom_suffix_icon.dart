import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key? key,
    this.svgIcon,
    this.color,
    this.onTap,
    this.normalIcon,
  }) : super(key: key);

  final String? svgIcon;
  final Icon? normalIcon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: svgIcon != null
            ? SvgPicture.asset(
                svgIcon!,
                height: getProportionateScreenWidth(18),
                color: color,
              )
            : normalIcon,
      ),
    );
  }
}
