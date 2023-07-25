import 'package:flutter/material.dart';
import 'package:tour_around/screens/sign_in/sign_in_screen.dart';
import 'package:tour_around/screens/splash/components/splash_content.dart';
import '../../../components/default_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/size_config.dart';

class BodySplash extends StatefulWidget {
  const BodySplash({Key? key}) : super(key: key);

  @override
  State<BodySplash> createState() => _BodySplashState();
}

class _BodySplashState extends State<BodySplash> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to TourAround, Go to places!",
      "image": "assets/images/welcoming.svg"
    },
    {
      "text": "We help you find touristic landmarks \nin Rwanda.",
      "image": "assets/images/touristic.svg"
    },
    {
      "text": "Who is going to stop you now?\n Touring Made easier.",
      "image": "assets/images/adventure_map_.svg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"]!,
                  text: splashData[index]['text']!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: tAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? tPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
