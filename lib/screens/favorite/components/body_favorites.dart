import 'package:flutter/material.dart';
import 'package:tour_around/constants/colors.dart';

class BodyFavorites extends StatefulWidget {
  const BodyFavorites({Key? key}) : super(key: key);

  @override
  State<BodyFavorites> createState() => _BodyFavoritesState();
}

class _BodyFavoritesState extends State<BodyFavorites> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "My Favorite Places",
        style: TextStyle(color: tPrimaryColor),
      ),
    );
  }
}
