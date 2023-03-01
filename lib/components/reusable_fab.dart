import 'package:flutter/material.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';

class ReusableFab extends StatefulWidget {
  const ReusableFab({
    super.key,
    this.isMini = true,
    this.bgColor = tPrimaryColor,
    required this.onPressed,
    required this.icon,
    this.matTapTargetSize = MaterialTapTargetSize.padded,
  });

  final bool isMini;
  final Color? bgColor;
  final IconData icon;
  final Function()? onPressed;
  final MaterialTapTargetSize? matTapTargetSize;

  @override
  State<ReusableFab> createState() => _ReusableFabState();
}

class _ReusableFabState extends State<ReusableFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      materialTapTargetSize: widget.matTapTargetSize,
      mini: widget.isMini,
      backgroundColor: widget.bgColor,
      child: Icon(
        widget.icon,
        size: getProportionateScreenWidth(26),
      ),
    );
  }
}
