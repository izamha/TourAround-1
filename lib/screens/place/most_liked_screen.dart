import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/screens/place/packages/details/package_detail.dart';
import 'package:tour_around/screens/place/packages/packages_screen.dart';

import '../../components/custom_bottom_navbar.dart';
import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/size_config.dart';
import '../../models/package.dart';
import '../../repository/package_repository.dart';
import '../my_places/components/no_data_yet.dart';
import '../sign_up/utils/auth_methods.dart';
import 'packages/widgets/package_item.dart';

class MostLikedScreen extends StatefulWidget {
  const MostLikedScreen({super.key});

  static String routeName = "/most_liked";

  @override
  State<MostLikedScreen> createState() => _MostLikedScreenState();
}

class _MostLikedScreenState extends State<MostLikedScreen> {
  final PackageRepository packageRepo = PackageRepository();
  DocumentSnapshot? snapshot;
  String userType = "";
  String userName = "";
  // BotttomNavigation
  final List<Map<String, dynamic>> _menuList = [
    {
      'menuState': MenuState.all,
      'routeName': PackagesScreen.routeName,
      'menuIcon': "assets/icons/maps-2.svg",
    },
    {
      'menuState': MenuState.mostLiked,
      'routeName': MostLikedScreen.routeName,
      'menuIcon': "assets/icons/heart-icon.svg",
    },
  ];

  void retrieveUserInfo() async {
    snapshot = await AuthMethods().getUserInfoTwo();

    setState(() {
      userName = snapshot!['username'];
      userType = snapshot!['userType'];
    });
  }

  @override
  void initState() {
    retrieveUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Most Liked",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: StreamBuilder<QuerySnapshot>(
            stream: packageRepo.getStream(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: tPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.size == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SvgPicture.asset(
                        "assets/images/no_data.svg",
                        width: 250,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      const Text(
                        "No packages available.",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              return _buildList(context, snapshot.data?.docs ?? []);
            }),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        selectedMenu: MenuState.mostLiked,
        menuList: _menuList,
      ),
    );
  }

  Widget _buildList(
      BuildContext context, List<QueryDocumentSnapshot<Object?>> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final package = Package.fromSnapshot(snapshot);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE6E6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            // const Spacer(),
            SvgPicture.asset("assets/icons/trash.svg"),
          ],
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          packageRepo.deletePlace(snapshot.id, context);
        });
      },
      child: package.postedBy == userName
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: PackageItem(
                text: package.packageName,
                price: package.packagePrice,
                icon: Icons.place,
                onPress: () => showPackageItem(package),
              ),
            )
          : const NoDataYet(dataName: "packages"),
    );
  }

  showPackageItem(
    Package package,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetails(package: package),
      ),
    );
  }
}
