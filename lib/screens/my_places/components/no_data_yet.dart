import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/size_config.dart';

class NoDataYet extends StatefulWidget {
  const NoDataYet({
    Key? key,
    required this.dataName,
  }) : super(key: key);

  final String dataName;

  @override
  State<NoDataYet> createState() => _NoDataYetState();
}

class _NoDataYetState extends State<NoDataYet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          SvgPicture.asset(
            "assets/images/no_data.svg",
            width: 250,
          ),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          Text(
            "You haven't added ${widget.dataName} yet.",
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
