import 'package:flutter/material.dart';
import 'package:tour_around/screens/complete_profile/components/body_complete_profile.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/complete_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Complete Profile"),
      ),
    body: const BodyCompleteProfile(),
    );
  }
}
