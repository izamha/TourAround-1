import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_around/constants/theme.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? userProfile;

  void loadProfileImage() async {
    Reference reference =
        _storage.ref().child("profileImages").child(_auth.currentUser!.uid);

    var photoUrl = await reference.getDownloadURL();

    setState(() {
      userProfile = photoUrl;
    });
  }

  @override
  void initState() {
    loadProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          userProfile == null
              ? const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(userProfile!),
                ),
          Positioned(
            bottom: 0,
            right: -12,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: flatRoundButtonStyle,
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/camera-icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
