import 'package:flutter/material.dart';
import 'package:tour_around/screens/place/packages/packages_screen.dart';

import '../../components/custom_bottom_navbar.dart';
import '../../constants/enums.dart';
import '../../constants/size_config.dart';

class MostLikedScreen extends StatefulWidget {
  const MostLikedScreen({super.key});

  static String routeName = "/most_liked";

  @override
  State<MostLikedScreen> createState() => _MostLikedScreenState();
}

class _MostLikedScreenState extends State<MostLikedScreen> {
  // BotttomNavigation
  final List<Map<String, dynamic>> _menuList = [
    {
      'menuState': MenuState.all,
      'routeName': PackagesScreen.routeName,
      'menuIcon': "assets/icons/maps-2.svg",
    },
    {
      'menuState': MenuState.mostLiked,
      'routeName': MostLikedScreen.routeName,
      'menuIcon': "assets/icons/heart-icon.svg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Most Liked",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text("Most Liked Packages"),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        selectedMenu: MenuState.mostLiked,
        menuList: _menuList,
      ),
    );
  }
}
