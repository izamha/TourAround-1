// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_around/models/user.dart' as CustomUser;
import 'package:tour_around/services/db_helper.dart';
import 'package:tour_around/utils/storage_methods.dart';
import 'package:uuid/uuid.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get User Info
  Future<CustomUser.User> getUserInfo() async {
    return await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
          (userData) => CustomUser.User.fromSnapshot(userData),
        );
  }

  Future<DocumentSnapshot> getUserInfoTwo() async {
    return await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get();
  }

  // Sign up the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String userType,
    required Uint8List file,
  }) async {
    String response = "Some error occured.";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          userType.isNotEmpty ||
          file != null) {
        // register the user
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl =
            await StorageMethods().uploadImageToStorage("profileImages", file);

        // add user to the cloud storage: Firebase
        CustomUser.User user = CustomUser.User(
          email: email,
          uid: userCredential.user!.uid,
          username: username,
          userType: userType,
          photoUrl: photoUrl,
        );

        CustomUser.User localUser = CustomUser.User(
          email: email,
          uid: const Uuid().v1(),
          username: username,
          password: password,
          userType: userType,
          photoUrl: photoUrl,
        );

        await _firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());

        // add user to sqflite
        await DatabaseHelper.instance.addUser(localUser);

        response = "success";
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String response = "Error";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        response = "success";
      } else {
        response = "Please fill all the fields";
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  Future<String> signInUserLocal({
    required String email,
    required String password,
  }) async {
    String response = "Error";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await DatabaseHelper.instance
            .signInUserWithLocalEmailAndPassword(email, password);
        response = "success";
      } else {
        response = "Please fill all the fields";
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }
}
