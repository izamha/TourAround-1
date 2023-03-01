import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/size_config.dart';


class NoPlacesYet extends StatelessWidget {
  const NoPlacesYet({
    Key? key,
  }) : super(key: key);

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
          const Text(
            "You haven't added places yet.",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
