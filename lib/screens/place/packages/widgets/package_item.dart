import 'package:flutter/material.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/constants/theme.dart';

class PackageItem extends StatefulWidget {
  const PackageItem({
    super.key,
    required this.text,
    required this.price,
    this.visitors,
    required this.icon,
    required this.onPress,
  });

  final String text;
  final String price;
  final int? visitors;
  final IconData icon;
  final Function() onPress;

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: getProportionateScreenHeight(18),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSnacksDesc(),
                      _buildPeopleDesc(),
                      _buildPriceDesc(),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnacksDesc() {
    return Row(
      children: const [
        Icon(
          Icons.check_circle_outline_outlined,
          size: 20.0,
        ),
        SizedBox(
          width: 2.0,
        ),
        Text(
          "Snacks",
          style: TextStyle(
            color: tTextColor,
            fontSize: 14.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPeopleDesc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(
          Icons.people_outline,
          color: tPrimaryColor,
          size: 20,
        ),
        SizedBox(
          width: 2.0,
        ),
        Text(
          "People",
          style: TextStyle(
            color: tTextColor,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDesc() {
    return Row(
      children: [
        const Icon(
          Icons.sell_outlined,
          color: tPrimaryColor,
          size: 20,
        ),
        const SizedBox(
          width: 2.0,
        ),
        Text(
          "\$${widget.price}",
          style: const TextStyle(
            color: tTextColor,
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }
}
