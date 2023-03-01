import 'package:flutter/material.dart';
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/constants/enums.dart';

import 'components/body_account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  static String routeName = "/my_account";
  final String userName;
  final String userEmail;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Account"),
      ),
      body: BodyAccount(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.profile),
    );
  }
}
