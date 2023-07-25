import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/repository/package_repository.dart';
import 'package:tour_around/screens/place/packages/details/package_detail.dart';
import 'package:tour_around/screens/place/packages/widgets/package_item.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
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
      height: SizeConfig.screenHeight,
      child: StreamBuilder<QuerySnapshot>(
        stream: packageRepo.getStream(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: tPrimaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return _buildList(context, snapshot.data?.docs ?? []);
          } else {
            return const Center(child: Text("No Packages to show"));
          }
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
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: PackageItem(
          text: package.packageName,
          price: package.packagePrice,
          icon: Icons.place,
          onPress: () => showPackageItem(package),
        ),
      ),
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
