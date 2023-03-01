import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/models/place.dart';

class CategoryItemDetails extends StatefulWidget {
  const CategoryItemDetails({
    super.key,
    required this.place,
  });

  static String routeName = "/category_item_details";

  final Place place;

  @override
  State<CategoryItemDetails> createState() => _CategoryItemDetailsState();
}

class _CategoryItemDetailsState extends State<CategoryItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tScaffoldBgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.place.placeName),
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                "assets/icons/heart-icon.svg",
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.place),
                    title: Text(
                      widget.place.placeName,
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      "Contacts",
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: tPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
