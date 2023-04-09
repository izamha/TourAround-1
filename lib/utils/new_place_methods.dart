import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tour_around/models/place.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
import 'package:tour_around/utils/storage_methods.dart';

class NewPlaceMethods {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create new place
  Future<String> createNewPlace({
    required String placeName,
    required String url,
    required String placeDesc,
    required double placeLat,
    required double placeLng,
    List<File>? placeImageUrl,
  }) async {
    String response = "Error";
    final userInfo = await AuthMethods().getUserInfo();
    try {
      if (placeName.isNotEmpty ||
          url.isNotEmpty ||
          placeDesc.isNotEmpty ||
          placeImageUrl != null) {
        List<String> photoUrls =
            await StorageMethods().uploadFiles(placeImageUrl!);

        // use the model
        Place newPlace = Place(
          lat: placeLat,
          lng: placeLng,
          placeName: placeName,
          url: url,
          placeDesc: placeDesc,
          placeImageUrls: photoUrls,
          postedBy: userInfo.username,
          createdAt: DateTime.now(),
        );

        // save to the firestore
        await _firestore.collection("places").add(
              newPlace.toJson(),
            );

        response = "Success";
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}
