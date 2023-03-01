import 'package:flutter/material.dart';
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/constants/enums.dart';
import 'package:tour_around/screens/favorite/components/body_favorites.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  static const routeName = "/favorites";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites"),
      ),
      body: const BodyFavorites(),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.favourite),
    );
  }
}
