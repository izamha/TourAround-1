import 'package:flutter/material.dart';
import 'package:tour_around/models/category.dart';
import 'package:tour_around/screens/category_detail/components/category_item_show_on_map.dart';
import 'package:tour_around/screens/category_detail/components/caterogy_item.dart';

class CategoryOnMapBody extends StatefulWidget {
  const CategoryOnMapBody({Key? key, required this.category})
      : super(key: key);

  final Category category;

  @override
  State<CategoryOnMapBody> createState() => _CategoryOnMapBodyState();
}

class _CategoryOnMapBodyState extends State<CategoryOnMapBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.categoryName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            widget.category.subCategory.length,
            (index) => CategoryItem(
              category: widget.category,
              text: widget.category.subCategory[index].subCategoryName,
              icon: widget.category.icon,
              onPress: () {
                showCategoryItem(
                  widget.category.subCategory[index].subCategoryName,
                  widget.category.subCategory[index].lat,
                  widget.category.subCategory[index].lng,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  showCategoryItem(
    String categoryName,
    double categoryItemLat,
    double categoryItemLng,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryItemShowOnMap(
          categoryName: categoryName,
          categoryItemLat: categoryItemLat,
          categoryItemLng: categoryItemLng,
        ),
      ),
    );
  }
}
