import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/models/category.dart';
import 'package:tour_around/screens/category_detail/category_on_map_screen.dart';
import 'package:tour_around/screens/home/home_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  static const routeName = "/categories";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Choose Categories"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            icon: const Icon(
              Icons.explore,
              color: tPrimaryColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/nature.svg",
                width: 350,
              ),
              SizedBox(
                height: getProportionateScreenHeight(60),
              ),
              Wrap(
                runSpacing: 5.0,
                spacing: 5.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                  categories.length,
                  (index) => Card(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: InkWell(
                      splashColor: tPrimaryColor.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryOnMap(
                              category: categories[index],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: getProportionateScreenWidth(160),
                        height: getProportionateScreenHeight(100),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  categories[index].icon,
                                  width: 28,
                                  color: tPrimaryColor,
                                ),
                              ),
                              Text(categories[index].categoryName),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
