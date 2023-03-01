import 'package:flutter/material.dart';
import 'package:tour_around/screens/complete_profile/components/complete_profile_form.dart';

import '../../../constants/heading_style.dart';
import '../../../constants/size_config.dart';


class BodyCompleteProfile extends StatelessWidget {
  const BodyCompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.02,
            ),
            Text(
              "Complete Profile",
              style: headingStyle,
            ),
            const Text(
              "Complete your details or continue \nwith social media",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.05,
            ),
            const CompleteProfileForm(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            const Text(
              "By continuing you confirm that you agree \nwith our Terms and Conditions",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
