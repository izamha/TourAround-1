import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as l;
import 'package:tour_around/components/custom_bottom_navbar.dart';
import 'package:tour_around/components/custom_snackbar.dart';
import 'package:tour_around/components/custom_suffix_icon.dart';
import 'package:tour_around/constants/enums.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/constants/theme.dart';
import 'package:tour_around/models/place.dart';
import 'package:tour_around/screens/home/components/show_images.dart';
import 'package:tour_around/screens/place/place_details_screen.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
import 'package:tour_around/screens/sign_up/utils/coordinate_distance.dart';
import 'package:tour_around/utils/new_place_methods.dart';
import '../../../constants/colors.dart';
import '../../../constants/api_keys.dart';
import '../../../repository/place_repository.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeUrlController = TextEditingController();
  final TextEditingController _placeDescController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  final _formKey = GlobalKey<FormState>();

  Set<Marker> markerList = {};
  final Set<Marker> _otherMarkers = {};
  final Mode _mode = Mode.overlay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController googleMapController;

  static const LatLng initLatLng =
      LatLng(-1.968126284060414, 30.063535657499877);

  List<LatLng> polylineCoordinates = [];
  l.LocationData? currentLocation;
  LatLng? _currentLatLng;
  MapType _currentMapType = MapType.normal;
  LatLng? _lastMapPosition;
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
  List<PlacesSearchResult> _placesSearchResult = [];

  List<File>? imageFileList = [];
  bool _isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  // UserInfo
  String? username;
  DocumentSnapshot? snapshot;
  FirebaseAuth? _auth;

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    _placeNameController.dispose();
    super.dispose();
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      selectedImages.forEach((image) {
        setState(() {
          imageFileList!.add(
            File(image.path),
          );
        });
      });
    }
  }

  void addNewPlace(LatLng position) async {
    String response = await NewPlaceMethods().createNewPlace(
      placeName: _placeNameController.text,
      url: _placeUrlController.text,
      placeDesc: _placeDescController.text,
      placeLat: position.latitude,
      placeLng: position.longitude,
      placeImageUrl: imageFileList,
    );

    _isLoading = true;

    if (response != "Success") {
      Future.delayed(Duration.zero).then(
        (value) {
          CustomSnackbar(
            snackTitle: "Error",
            text: response,
          );
        },
      );
    } else {
      Future.delayed(Duration.zero).then(
        (value) {
          const CustomSnackbar(
            snackTitle: "Success",
            text: "Successfully saved!",
          );
        },
      );
    }
  }

  void addMarkerNewPlace(LatLng position) {
    setState(() {
      _otherMarkers.add(
        Marker(
          markerId: MarkerId(
            position.toString(),
          ),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: _placeNameController.text,
            snippet: "Added place",
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            removeMarker(position);
          },
        ),
      );
      // Dismiss
      Navigator.pop(context);
    });
  }

  void getCurrentLocation() async {
    l.Location location = l.Location();

    location.getLocation().then(
          (location) => {currentLocation = location},
        );

    googleMapController = await _controller.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14.5,
          target: LatLng(initLatLng.latitude, initLatLng.longitude),
        ),
      ),
    );
    setState(() {});

    // location.onLocationChanged.listen((newLoc) {
    //   currentLocation = newLoc;
    //   googleMapController.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         zoom: 14.5,
    //         target: LatLng(newLoc.latitude!, newLoc.longitude!),
    //       ),
    //     ),
    //   );
    //   setState(() {});
    // });
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/pin-source.png")
        .then(
      (icon) => {sourceIcon = icon},
    );

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/pin-destination.png")
        .then(
      (icon) => {destinationIcon = icon},
    );

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/profile-image.png")
        .then(
      (icon) => {currentLocationIcon = icon},
    );
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _otherMarkers.add(
        Marker(
          markerId: MarkerId(
            _lastMapPosition.toString(),
          ),
          position: _lastMapPosition!,
          infoWindow: const InfoWindow(
            title: "A great place to visit!",
            snippet: "Added place",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  void removeMarker(LatLng position) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Delete this Place?"),
        content: const Text(
            "You are going to permanently delete this place. It won't show on the map again."),
        actions: [
          TextButton(
            onPressed: (() => Navigator.pop(context, 'Cancel')),
            child: const Text(
              "Cancel",
              style: TextStyle(color: tPrimaryColor),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "More...",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: (() {
              setState(() {
                _otherMarkers.removeWhere(
                  (marker) => marker.markerId.value == position.toString(),
                );
                Navigator.pop(context, 'Delete');
              });
            }),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapLongPressed(LatLng position) {
    setState(() {
      _auth = FirebaseAuth.instance;
    });
    if (_auth != null) {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text("Add Place"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      imageFileList!.isEmpty
                          ? Stack(
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                  margin: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/image-placeholder.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -3,
                                  child: SizedBox(
                                    height: 46,
                                    width: 46,
                                    child: TextButton(
                                      style: flatRoundButtonStyle,
                                      onPressed: selectImages,
                                      child: SvgPicture.asset(
                                          "assets/icons/camera-icon.svg"),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * .24,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: tScaffoldBgColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          getProportionateScreenWidth(5),
                                        ),
                                      ),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: GridView.builder(
                                        itemCount: imageFileList!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ),
                                        itemBuilder: (context, index) {
                                          return ShowImage(
                                            imageFileList: imageFileList,
                                            index: index,
                                          );
                                        }),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: -12,
                                    child: SizedBox(
                                      height: 46,
                                      width: 46,
                                      child: TextButton(
                                        style: flatRoundButtonStyle,
                                        onPressed: selectImages,
                                        child: SvgPicture.asset(
                                            "assets/icons/camera-icon.svg"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      buildAddPlaceForm(position),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        imageFileList!.clear();
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text("Preview Images"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // _isLoading = true;
                        Future.delayed(const Duration(seconds: 2), () {
                          addNewPlace(position);
                          addMarkerNewPlace(position);
                        });
                      });
                    },
                    child: const Text("Save"),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            snackTitle: "Add Error",
            text: "Can't add place. Sign in first.",
          ),
        ),
      );
    }
  }

  void _retrieveUserInfo() async {
    snapshot = await AuthMethods().getUserInfoTwo();
    setState(() {
      username = snapshot!['username'];
    });
  }

  Future getCustomLocations() async {
    final PlaceRepository repository = PlaceRepository();
    final dataStream = repository.getStream();
    dataStream.forEach((field) {
      field.docs.asMap().forEach((key, value) {
        // _placeList.add(field.docs[key].data()!);
        _otherMarkers.add(
          Marker(
            markerId: MarkerId(
              field.docs[key].get('placeName'),
            ),
            position: LatLng(
              field.docs[key].get('lat'),
              field.docs[key].get('lng'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetailsScreen(
                    place: Place(
                      lat: field.docs[key].get('lat'),
                      lng: field.docs[key].get('lng'),
                      placeName: field.docs[key].get('placeName'),
                      url: field.docs[key].get('url'),
                      placeDesc: field.docs[key].get('placeDesc'),
                      placeImageUrls:
                          List.from(field.docs[key].get('placeImageUrls')),
                    ),
                  ),
                ),
              );
            },
            infoWindow: InfoWindow(
              title: field.docs[key].get('placeName'),
              snippet: field.docs[key].get('placeDesc'),
            ),
          ),
        );
      });
    });
  }

  void setCurrentLocation() {
    // Set currentLocation
    Geolocator.getCurrentPosition().then((currentLoc) {
      setState(() {
        _currentLatLng = LatLng(currentLoc.latitude, currentLoc.longitude);
        _otherMarkers.addAll([
          Marker(
            markerId: const MarkerId("currentLoc"),
            position: LatLng(currentLoc.latitude, currentLoc.longitude),
            infoWindow: const InfoWindow(
              title: "Me",
              snippet: "Here I am!",
            ),
          ),
          // Marker(
          //   markerId: const MarkerId("destinationLoc"),
          //   position: LatLng(initLatLng.latitude, initLatLng.longitude),
          //   infoWindow: const InfoWindow(
          //     title: "Destination 2",
          //     snippet: "Not me",
          //   ),
          // ),
        ]);
        // getPolyPoints(_currentLatLng!, initLatLng);
      });
    });
  }

  void getPolyPoints(LatLng fromHere, LatLng toThere) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(fromHere.latitude, fromHere.longitude), // origin
      PointLatLng(toThere.latitude, toThere.longitude), // destination
    );

    // Calculate the distance between the two co-ordinates

    // Make sure there's no exisiting polyline
    polylineCoordinates.clear();

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach(
        (PointLatLng pointLatLng) => polylineCoordinates.add(
          LatLng(pointLatLng.latitude, pointLatLng.longitude),
        ),
      );
      double distanceInMeters = distanceBetween(fromHere.latitude,
          fromHere.longitude, toThere.latitude, toThere.longitude);

      Future.delayed(Duration.zero).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomSnackbar(
              text: "$distanceInMeters km",
              bubbleColor: const Color.fromARGB(255, 230, 234, 241),
              snackbarColor: tPrimaryColor,
              snackTitle: "Total Distance",
            ),
            duration: const Duration(milliseconds: 15000),
            backgroundColor: Colors.transparent,
          ),
        ),
      );

      setState(() {});
    }
  }

  void getProximities(LatLng newPosition) async {
    final location =
        Location(lat: newPosition.latitude, lng: newPosition.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);

    List types = [
      "point_of_interest",
      "lodging",
      "embassy",
      "bank",
      "spa",
      "restaurant",
      "locality",
    ];

    setState(() {
      _placesSearchResult = result.results;
      _placesSearchResult.forEach((place) {
        final marker = Marker(
          markerId: MarkerId(place.placeId),
          position: LatLng(
              place.geometry!.location.lat, place.geometry!.location.lng),
          infoWindow: InfoWindow(title: place.name, snippet: place.types.first),
          draggable: false,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        );
        _otherMarkers.add(marker);
      });
    });
  }

  @override
  void initState() {
    _retrieveUserInfo();
    getCustomLocations(); // Custom added places
    setCurrentLocation();
    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("TourAround"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: onSearchIconPressed,
              customBorder: const CircleBorder(),
              splashColor: tPrimaryColor.withOpacity(0.6),
              child: SvgPicture.asset(
                "assets/icons/search-map.svg",
                height: 32,
                color: tPrimaryColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
      body: _currentLatLng == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _currentLatLng!.latitude, _currentLatLng!.longitude),
                  ),
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      points: polylineCoordinates,
                      color: Colors.blue,
                      width: 6,
                    ),
                  },
                  markers: _otherMarkers,
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                  onLongPress: _onMapLongPressed,
                  onCameraMove: _onCameraMove,
                  mapType: _currentMapType,
                  myLocationButtonEnabled: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          mini: true,
                          onPressed: _onMapTypeButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: tPrimaryColor,
                          child: Icon(
                            Icons.map,
                            size: getProportionateScreenHeight(26.0),
                          ),
                        ),
                        // FloatingActionButton(
                        //   mini: true,
                        //   onPressed: getCustomLocations,
                        //   materialTapTargetSize: MaterialTapTargetSize.padded,
                        //   backgroundColor: tPrimaryColor,
                        //   child: const Icon(
                        //     Icons.add_location,
                        //     size: 26.0,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar:
          const CustomBottomNavbar(selectedMenu: MenuState.home),
    );
  }

  Future<dynamic> bottomSheets(LatLng position, Color color, String text) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: getProportionateScreenHeight(400.0),
            color: color,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                buildAddPlaceForm(position),
              ],
            ),
          );
        });
  }

  Form buildAddPlaceForm(LatLng position) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber),
              RichText(
                text: TextSpan(
                  text: 'Lat and Lng shall be auto-saved.',
                  style: DefaultTextStyle.of(context).style,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildPlaceNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildUrlFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildLatFormField(position),
          buildLngFormField(position),
          buildPlaceDescFormField(),
        ],
      ),
    );
  }

  Visibility buildLngFormField(LatLng position) {
    return Visibility(
      visible: false,
      child: TextFormField(
        // controller: _lngNameController,
        initialValue: "${position.longitude}",
        enabled: false,
        decoration: const InputDecoration(
          labelText: "Longitude",
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location.svg"),
        ),
      ),
    );
  }

  Visibility buildLatFormField(LatLng position) {
    return Visibility(
      visible: false,
      child: TextFormField(
        // controller: _latController,
        enabled: false,
        initialValue: "${position.latitude}",
        decoration: const InputDecoration(
          labelText: "Latitude",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location.svg"),
          suffixIconColor: tPrimaryColor,
        ),
      ),
    );
  }

  TextFormField buildPlaceNameFormField() {
    return TextFormField(
      controller: _placeNameController,
      decoration: const InputDecoration(
        labelText: "Place Name",
        hintText: "My New Place",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/pen.svg"),
        suffixIconColor: tPrimaryColor,
      ),
    );
  }

  TextFormField buildUrlFormField() {
    return TextFormField(
      controller: _placeUrlController,
      keyboardType: TextInputType.url,
      decoration: const InputDecoration(
        labelText: "URL",
        hintText: "Link to place",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/location.svg"),
        suffixIconColor: tPrimaryColor,
      ),
    );
  }

  TextFormField buildPlaceDescFormField() {
    return TextFormField(
      controller: _placeDescController,
      decoration: const InputDecoration(
        labelText: "Place Description",
        hintText: "Place Descriptions",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/pen.svg"),
        suffixIconColor: tPrimaryColor,
      ),
      minLines: 1,
      maxLines: 3,
      maxLength: 140,
    );
  }

  Future<void> onSearchIconPressed() async {
    Prediction? prediction = (await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      strictbounds: false,
      types: [],
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white)),
      ),
      components: [
        Component(Component.country, "rw"),
      ],
    ));

    displayPrediction(prediction!, scaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SnackBar(
          content: Text(response.errorMessage!),
        ),
      ),
    );
  }

  Future<void> displayPrediction(
      Prediction prediction, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: googleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detailsResponse =
        await places.getDetailsByPlaceId(prediction.placeId!);

    final lat = detailsResponse.result.geometry!.location.lat;
    final lng = detailsResponse.result.geometry!.location.lng;

    Place place =
        Place(lat: lat, lng: lng, placeName: detailsResponse.result.name);

    // markerList.clear();

    _otherMarkers.add(
      Marker(
        markerId: MarkerId(place.placeName.toString()),
        position: LatLng(lat, lng),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailsScreen(place: place),
            ),
          );
        },
      ),
    );

    setState(() {
      getPolyPoints(_currentLatLng!, LatLng(lat, lng));
      getProximities(LatLng(lat, lng));
    });

    googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 17.5),
    );
  }
}
