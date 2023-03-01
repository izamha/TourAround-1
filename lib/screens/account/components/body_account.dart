import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';

import '../../../constants/theme.dart';

class BodyAccount extends StatefulWidget {
  const BodyAccount({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  final String userName, userEmail;

  @override
  State<BodyAccount> createState() => _BodyAccountState();
}

class _BodyAccountState extends State<BodyAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/images/add_profile.svg",
            width: 300,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              AccountMenu(
                text: widget.userName,
                icon: "assets/icons/user-icon.svg",
                onPress: () {},
                iconWidget: const Icon(Icons.edit),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              AccountMenu(
                text: widget.userEmail,
                icon: "assets/icons/mail.svg",
                onPress: () {},
                iconWidget: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPress,
      required this.iconWidget})
      : super(key: key);

  final String text, icon;
  final VoidCallback onPress;
  final Icon iconWidget;

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
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            iconWidget,
          ],
        ),
      ),
    );
  }
}
