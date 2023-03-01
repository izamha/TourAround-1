import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_around/models/place.dart';
import 'package:tour_around/screens/sign_up/utils/show_snack_bar.dart';

class PlaceRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Place> getPlaces() async {
  
    return await _firestore
        .collectionGroup("places")
        .get()
        .then((placeData) => Place.fromSnapshot(placeData.docs.first));
  }

  Stream<QuerySnapshot> getStream() {
    return _firestore.collectionGroup("places").snapshots();
  }

  Future<DocumentReference> addPlace(Place place) {
    return _firestore.collection("places").add(place.toJson());
  }

  // Future<void> updatePlace([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     await _firestore
  //         .collection("places")
  //         .doc(documentSnapshot.id)
  //         .update({'isVisible': true});
  //   }
  // }

   Future<void> updatePlace(String field, bool value, [DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      await _firestore
          .collection("places")
          .doc(documentSnapshot.id)
          .update({field: value});
    }
  }

  Future<void> deletePlace(String placeId, BuildContext context) async {
    await _firestore.collection("places").doc(placeId).delete();
    Future.delayed(Duration.zero).then((value) {
      showSnackBar("Successfully deleted a place!", context);
    });
  }
}
