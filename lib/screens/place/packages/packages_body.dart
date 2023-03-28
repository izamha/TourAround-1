import 'package:flutter/material.dart';
import 'package:tour_around/screens/place/packages/details/package_detail.dart';
import 'package:tour_around/screens/place/packages/widgets/package_item.dart';

class PackagesBody extends StatefulWidget {
  const PackagesBody({
    super.key,
  });

  @override
  State<PackagesBody> createState() => _PackagesBodyState();
}

class _PackagesBodyState extends State<PackagesBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20,
          (index) => PackageItem(
            text: "packageItem #${index + 1}",
            icon: Icons.place,
            onPress: () {
              showPackageItem("packageItem #${index + 1}");
            },
          ),
        ),
      ),
    );
  }

  showPackageItem(
    String packageName,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetails(packageName: packageName),
      ),
    );
  }
}
