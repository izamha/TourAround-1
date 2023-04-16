import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/components/expandable_card.dart';
import 'package:tour_around/repository/package_repository.dart';
import 'package:tour_around/screens/my_places/components/no_data_yet.dart';
import 'package:tour_around/screens/place/packages/details/package_detail.dart';
import 'package:tour_around/screens/place/packages/widgets/package_item.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
import 'package:tour_around/utils/new_package_methods.dart';

import '../../../constants/colors.dart';
import '../../../constants/size_config.dart';
import '../../../models/package.dart';

class PackagesBody extends StatefulWidget {
  const PackagesBody({
    super.key,
  });

  @override
  State<PackagesBody> createState() => _PackagesBodyState();
}

class _PackagesBodyState extends State<PackagesBody> {
  final PackageRepository packageRepo = PackageRepository();

  DocumentSnapshot? snapshot;
  String userType = "";
  String userName = "";
  bool isExpanded = false;

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
    return SizedBox(
      height: 400,
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
