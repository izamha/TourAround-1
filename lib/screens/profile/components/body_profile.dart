import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/models/user.dart' as CustomUser;
import 'package:tour_around/screens/account/account_screen.dart';
import 'package:tour_around/screens/help/help_screen.dart';
import 'package:tour_around/screens/profile/components/profile_menu.dart';
import 'package:tour_around/screens/profile/components/profile_picture.dart';
import 'package:tour_around/screens/settings/settings_screen.dart';
import 'package:tour_around/screens/sign_in/sign_in_screen.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
import 'package:tour_around/screens/sign_up/utils/show_dialog.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  GoogleSignInAccount? _currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CustomUser.User? userInfo;
  String userName = "";
  DocumentSnapshot? snapshot;

  void getUserInfo() async {
    userInfo = await AuthMethods().getUserInfo();
    snapshot = await AuthMethods().getUserInfoTwo();
    setState(() {
      userName = snapshot!['username'];
    });
  }

  @override
  void initState() {
    // UserType
    getUserInfo();
    _googleSignIn.onCurrentUserChanged.listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Column(
      children: [
        const ProfilePicture(),
        Padding(
          padding: EdgeInsets.all(
            getProportionateScreenWidth(20.0),
          ),
          child: Column(
            children: [
              Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Text(
                user == null ? _auth.currentUser?.email ?? '' : user.email,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: "assets/icons/user-icon.svg",
          text: "My Account",
          onPress: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountScreen(
                userName: userName,
                userEmail:
                    user == null ? _auth.currentUser?.email ?? '' : user.email,
              ),
            ),
          ),
        ),
        ProfileMenu(
          icon: "assets/icons/settings.svg",
          text: "Settings",
          onPress: () => Navigator.pushNamed(context, SettingsScreen.routeName),
        ),
        ProfileMenu(
          icon: "assets/icons/question-mark.svg",
          text: "Help Center",
          onPress: () => Navigator.pushNamed(context, HelpScreen.routeName),
        ),
        ProfileMenu(
          icon: "assets/icons/log-out.svg",
          text: "Sign Out",
          onPress: signOut,
        ),
      ],
    );
  }

  void signOut() {
    showCustomizableDialog(
      context,
      const Text("Sign Out"),
      const Text(
        "Are you sure?",
        style: TextStyle(fontSize: 20),
      ),
      "Logout",
      () {
        _googleSignIn.disconnect();
        // Quickly go back
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      },
    );
  }
}
