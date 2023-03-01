import 'package:flutter/material.dart';
import 'package:tour_around/models/category.dart';
import 'package:tour_around/screens/category_detail/components/category_on_map_body.dart';

class CategoryOnMap extends StatefulWidget {
  const CategoryOnMap({
    Key? key,
    required this.category,
  }) : super(key: key);

  static const routeName = "/category/detail";

  final Category category;

  @override
  State<CategoryOnMap> createState() => _CategoryOnMapState();
}

class _CategoryOnMapState extends State<CategoryOnMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryOnMapBody(category: widget.category),
    );
  }
}
