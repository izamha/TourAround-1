import 'package:flutter/material.dart';
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/constants/enums.dart';

import 'components/body_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static String routeName = "/settings";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: const BodySettings(),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.profile),
    );
  }
}
