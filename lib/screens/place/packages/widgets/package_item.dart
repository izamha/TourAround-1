import 'package:flutter/material.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/constants/theme.dart';

class PackageItem extends StatefulWidget {
  const PackageItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onPress,
  });

  final String text;
  final IconData icon;
  final Function() onPress;

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: flatButtonStyle,
      onPressed: widget.onPress,
      child: Row(
        children: [
          Icon(
            widget.icon,
            size: getProportionateScreenWidth(22.0),
          ),
          SizedBox(
            width: getProportionateScreenWidth(20.0),
          ),
          Expanded(
            child: Text(
              widget.text,
              style: TextStyle(
                color: tTextColor,
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
