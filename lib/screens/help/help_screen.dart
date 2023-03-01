import 'package:flutter/material.dart';
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/constants/enums.dart';

import 'components/body_help.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  static String routeName = "/help";

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Help"),
      ),
      body: const BodyHelp(),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.profile),
    );
  }
}
