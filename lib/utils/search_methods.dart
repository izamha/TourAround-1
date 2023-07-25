import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../constants/api_keys.dart';

class SearchMethods {
  final Mode _mode = Mode.overlay;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _onSearchIconPressed(BuildContext context) async {
    Prediction? prediction = (await PlacesAutocomplete.show(
        context: context,
        apiKey: googleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
        ),
        components: [
          Component(Component.country, "rw"),
          // Component(Component.country, "usa")
        ]));

    // displayPrediction(prediction!, scaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    // scaffoldKey.currentState!.showSnackBar(
    //   SnackBar(
    //     content: Text(response.errorMessage!),
    //   ),
    // );
  }

  Future<void> displayPrediction(
      Prediction prediction,
      ScaffoldState? currentState,
      Completer<GoogleMapController> controller) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: googleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detailsResponse =
        await places.getDetailsByPlaceId(prediction.placeId!);

    final lat = detailsResponse.result.geometry!.location.lat;
    final lng = detailsResponse.result.geometry!.location.lng;

    // markerList.clear();
    // markerList.add(
    //   Marker(
    //     markerId: const MarkerId("0"),
    //     position: LatLng(lat, lng),
    //     infoWindow: InfoWindow(title: detailsResponse.result.name),
    //   ),
    // );

    // setState(() {});

    // googleMapController = await controller.future;
    // googleMapController.animateCamera(
    //   CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15.5),
    // );
  }

  // setState(() {
  //           markers.add(Marker(
  //             markerId: MarkerId(point.toString()),
  //             position: point,
  //             infoWindow: InfoWindow(
  //               title: 'I am a marker in ${point}',
  //             ),
  //             icon: BitmapDescriptor.defaultMarkerWithHue(
  //                 BitmapDescriptor.hueMagenta),
  //             anchor: const Offset(0.5, 0.5),
  //           ));
  //         });
}
