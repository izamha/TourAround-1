import 'package:flutter/material.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/place/packages/packages_body.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Place Packages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: getProportionateScreenHeight(20),
            splashColor: tPrimaryColor,
            onPressed: () {},
            icon: const Icon(
              Icons.add_home_work_outlined,
              color: tPrimaryColor,
            ),
          ),
        ],
        elevation: 6.0,
      ),
      body: const PackagesBody(),
    );
  }
}
