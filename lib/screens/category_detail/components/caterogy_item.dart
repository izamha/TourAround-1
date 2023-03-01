import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/theme.dart';

import '../../../constants/colors.dart';
import '../../../models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.text,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final String text, icon;
  final Category category;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: flatButtonStyle,
        onPressed: onPress,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              color: tPrimaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
