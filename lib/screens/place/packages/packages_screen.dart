import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/place/packages/packages_body.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Place Packages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: getProportionateScreenHeight(20),
            splashColor: tPrimaryColor,
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddPackageDialog();
                }),
            icon: const Icon(
              Icons.add_home_work_outlined,
              color: tPrimaryColor,
            ),
          ),
        ],
        elevation: 6.0,
      ),
      body: const PackagesBody(),
    );
  }
}

class AddPackageDialog extends StatefulWidget {
  const AddPackageDialog({super.key});

  @override
  State<AddPackageDialog> createState() => _AddPackageDialogState();
}

class _AddPackageDialogState extends State<AddPackageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Icon(
            Icons.draw_outlined,
            color: tPrimaryColor,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "Create a Package",
            style: TextStyle(
              color: tPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/add_package.svg",
                width: 100,
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 38,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Package Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              SizedBox(
                height: 38,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Package Price',
                  ),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              SizedBox(
                height: 100,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 14.0, top: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Package Descriptions',
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: tPrimaryColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            // Save functionality
            Navigator.of(context).pop();
          },
          child: const Text(
            "Save",
            style: TextStyle(
              color: tPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
