import 'package:tour_around/models/sub_category.dart';

class Category {
  final String categoryName;
  final String icon;
  final List<SubCategory> subCategory;

  const Category({
    required this.categoryName,
    required this.icon,
    required this.subCategory,
  });
}

List<Category> categories = [
  const Category(
    categoryName: "Parks",
    icon: "assets/icons/park.svg",
    subCategory: [
      SubCategory(
          subCategoryName: "Akagera National Park",
          lat: -1.8082378512506931,
          lng: 30.698526630988546),
      SubCategory(
          subCategoryName: "Gishwati-Mukura National Park",
          lat: -1.816278777988831,
          lng: 29.351040715134214),
      SubCategory(
          subCategoryName: "Nyungwe National Park",
          lat: -2.480896278505237,
          lng: 29.215051996510724),
      SubCategory(
          subCategoryName: "Nyandungu Urban Wetland Eco-tourism Park",
          lat: -1.955272588691881,
          lng: 30.145337754179742),
      SubCategory(
          subCategoryName: "Volcanoes National Park",
          lat: -1.352691151767288,
          lng: 29.58106389187418),
    ],
  ),
  const Category(
    categoryName: "Rivers",
    icon: "assets/icons/rivers.svg",
    subCategory: [
      SubCategory(
          subCategoryName: "Akagera",
          lat: -1.5818802291303724,
          lng: 30.840293408891412),
      SubCategory(
          subCategoryName: "Mwogo",
          lat: -2.2643932027762927,
          lng: 29.601478627354364),
      SubCategory(
          subCategoryName: "Akanyaru",
          lat: -2.2063343099337542,
          lng: 29.98653463288882),
      SubCategory(
          subCategoryName: "Nyabarongo",
          lat: -2.0198427799124774,
          lng: 29.988467639163023),
      SubCategory(
          subCategoryName: "Sebeya",
          lat: -1.6906011657761018,
          lng: 29.284576619648124),
    ],
  ),
  const Category(
    categoryName: "Forests",
    icon: "assets/icons/forests.svg",
    subCategory: [
      SubCategory(
          subCategoryName: "Gishwati Forest",
          lat: -1.8162358828813443,
          lng: 29.351072898354563),
      SubCategory(
          subCategoryName: "Nyungwe Forest",
          lat: -2.481035622635518,
          lng: 29.215084183015875),
      SubCategory(
          subCategoryName: "Cyamudongo Forest",
          lat: -2.5454725769713114,
          lng: 28.98800773874099),
      SubCategory(
          subCategoryName: "Rutegamasunzu Forest",
          lat: -1.8657031273658005,
          lng: 29.574197525344356),
      SubCategory(
          subCategoryName: "Mount Kigali Forest",
          lat: -1.9646793029479304,
          lng: 30.043133598355098),
    ],
  ),
  const Category(
    categoryName: "Lakes",
    icon: "assets/icons/rivers.svg",
    subCategory: [
      SubCategory(
          subCategoryName: "Lake Kivu",
          lat: -1.9697271834715757,
          lng: 29.168539016908436),
      SubCategory(
          subCategoryName: "Lake Mugesera",
          lat: -2.0927207666721226,
          lng: 30.32655377761573),
      SubCategory(
          subCategoryName: "Lake Ruhondo",
          lat: -1.4917105825897856,
          lng: 29.724110683452263),
      SubCategory(
          subCategoryName: "Lake Muhazi",
          lat: -1.8521840851350233,
          lng: 30.374061574408522),
      SubCategory(
          subCategoryName: "Lake Burera",
          lat: -1.4322903598321903,
          lng: 29.77445044396014),
      SubCategory(
          subCategoryName: "Lake Rweru",
          lat: -2.3742637153100343,
          lng: 30.318562836886027),
      SubCategory(
          subCategoryName: "Lake Sake",
          lat: -2.2357448766864296,
          lng: 30.37255535857787),
      SubCategory(
          subCategoryName: "Lake Ihema",
          lat: -1.861765396792408,
          lng: 30.79134319886779),
    ],
  ),
  const Category(
    categoryName: "Museums",
    icon: "assets/icons/museum.svg",
    subCategory: [
      SubCategory(
          subCategoryName: "King's Palace Museum",
          lat: -2.3599606430420015,
          lng: 29.74063928301557),
      SubCategory(
          subCategoryName: "Rwanda Art Museum",
          lat: -1.9750697167152855,
          lng: 30.173076654179706),
      SubCategory(
          subCategoryName: "National Liberation Museum",
          lat: -1.4765295187360008,
          lng: 30.0360468388386),
    ],
  ),
  const Category(
    categoryName: "Tour Companies",
    icon: "assets/icons/car.svg",
    subCategory: [
      SubCategory(
          subCategoryName: "Golden Tours",
          lat: -1.3020153509638137,
          lng: 30.191325730606966),
      SubCategory(
          subCategoryName: "Nepo Tours",
          lat: -1.9703538262373845,
          lng: 30.104482640684825),
      SubCategory(subCategoryName: "King Tours", lat: 0, lng: 1),
    ],
  ),
];
