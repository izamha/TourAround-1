import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/enums.dart';
import 'package:tour_around/screens/favorite/favorite_screen.dart';
import 'package:tour_around/screens/my_places/my_places_screen.dart';

import '../constants/colors.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              icon: SvgPicture.asset(
                "assets/icons/maps-2.svg",
                color: MenuState.home == selectedMenu
                    ? tPrimaryColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoriteScreen.routeName);
              },
              icon: SvgPicture.asset(
                "assets/icons/heart-icon.svg",
                color: MenuState.favourite == selectedMenu
                    ? tPrimaryColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyPlacesScreen.routeName),
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                height: 24,
                color: MenuState.places == selectedMenu
                    ? tPrimaryColor
                    : inActiveIconColor,
              ),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ProfileScreen.routeName),
              icon: SvgPicture.asset(
                "assets/icons/user-icon.svg",
                color: MenuState.profile == selectedMenu
                    ? tPrimaryColor
                    : inActiveIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
