import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_around/models/package.dart';

import '../screens/sign_up/utils/show_snack_bar.dart';

class PackageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Package> getPackages() async {
    return await _firestore.collection("packages").get().then(
          (packageData) => Package.fromSnapshot(packageData.docs.first),
        );
  }

  Stream<QuerySnapshot> getStream() {
    Stream data = _firestore.collection("packages").snapshots();
    debugPrint("$data");
    return _firestore.collection("packages").snapshots();
  }

  Future<DocumentReference> addPackage(Package package) {
    return _firestore.collection("packages").add(package.toJson());
  }

  // Future<void> updatePackage(String field, [DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     await _firestore.collection("packages").doc(documentSnapshot.id).update({field});
  //   }
  // }

  Future<void> deletePlace(String placeId, BuildContext context) async {
    await _firestore.collection("packages").doc(placeId).delete();
    Future.delayed(Duration.zero).then((value) {
      showSnackBar("Successfully deleted a package!", context);
    });
  }
}
