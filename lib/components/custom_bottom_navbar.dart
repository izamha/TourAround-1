import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/enums.dart';

import '../constants/colors.dart';
import '../screens/favorite/favorite_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/my_places/my_places_screen.dart';
import '../screens/profile/profile_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  // BotttomNavigation
  final List<Map<String, dynamic>> _menuList = [
    {
      'menuState': MenuState.home,
      'routeName': HomeScreen.routeName,
      'menuIcon': "assets/icons/maps-2.svg",
    },
    {
      'menuState': MenuState.favourite,
      'routeName': FavoriteScreen.routeName,
      'menuIcon': "assets/icons/heart-icon.svg",
    },
    {
      'menuState': MenuState.places,
      'routeName': MyPlacesScreen.routeName,
      'menuIcon': "assets/icons/location.svg",
    },
    {
      'menuState': MenuState.profile,
      'routeName': ProfileScreen.routeName,
      'menuIcon': "assets/icons/user-icon.svg",
    },
  ];
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
          children: List.generate(
            _menuList.length,
            (index) => IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, _menuList[index]['routeName']),
              icon: SvgPicture.asset(
                _menuList[index]['menuIcon'],
                color: _menuList[index]['menuState'] == widget.selectedMenu
                    ? tPrimaryColor
                    : inActiveIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
