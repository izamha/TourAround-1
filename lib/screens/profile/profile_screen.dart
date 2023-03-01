import 'package:flutter/material.dart';
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/constants/enums.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/profile/components/body_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/profle";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: const BodyProfile(),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.profile),
    );
  }
}
