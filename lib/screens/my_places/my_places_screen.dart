import 'package:flutter/material.dart';
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/constants/enums.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/my_places/components/places_body_new.dart';

class MyPlacesScreen extends StatefulWidget {
  static const routeName = "/my_places";

  const MyPlacesScreen({Key? key}) : super(key: key);

  @override
  State<MyPlacesScreen> createState() => _MyPlacesScreenState();
}

class _MyPlacesScreenState extends State<MyPlacesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Places"),
      ),
      body: const PlacesBodyNew(),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.places),
    );
  }
}
