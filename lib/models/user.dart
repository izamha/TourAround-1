import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String? password;
  final String? userType;

  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    this.password,
    this.userType,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "userType": userType,
      };

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final newPlace = User.fromJson(snapshot.data() as Map<String, dynamic>);
    // newPlace.referenceId = snapshot.reference.id;
    return newPlace;
  }

  static User fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        uid: json['uid'],
        photoUrl: json['photoUrl'],
        username: json['username'],
        password: json['password'],
        userType: json['userType'],
      );
}
