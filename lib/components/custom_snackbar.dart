import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/size_config.dart';

class CustomSnackbar extends StatefulWidget {
  const CustomSnackbar({
    super.key,
    required this.text,
    this.snackbarColor = const Color(0xFFC72C41),
    this.bubbleColor = const Color(0xFF801336),
    this.type = "error",
    required this.snackTitle,
    this.closeIconColor = const Color(0xFFC72C41),
  });

  final String text;
  final Color snackbarColor;
  final Color bubbleColor;
  final String type;
  final String snackTitle;
  final Color closeIconColor;

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: widget.snackbarColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snackTitle,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      widget.text,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
              "assets/icons/bubbles.svg",
              height: 48,
              width: 40,
              color: widget.bubbleColor,
            ),
          ),
        ),
        Positioned(
          top: getProportionateScreenHeight(-15),
          left: 0,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/fail.svg",
                  height: getProportionateScreenHeight(40),
                  colorFilter: ColorFilter.mode(
                    widget.closeIconColor,
                    BlendMode.dstIn,
                  ),
                ),
                Positioned(
                  top: 10,
                  child: SvgPicture.asset(
                    "assets/icons/close-icon.svg",
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
