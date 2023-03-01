import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tour_around/components/reusable_fab.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/screens/category_detail/components/category_item_details.dart';
import 'package:tour_around/screens/category_detail/components/travel_form.dart';
import 'package:tour_around/screens/home/home_screen.dart';
import '../../../components/custom_snackbar.dart';
import '../../../constants/api_keys.dart';
import '../../../models/place.dart';
import '../../sign_up/utils/coordinate_distance.dart';

class CategoryItemShowOnMap extends StatefulWidget {
  const CategoryItemShowOnMap({
    Key? key,
    required this.categoryName,
    required this.categoryItemLat,
    required this.categoryItemLng,
  }) : super(key: key);

  final String categoryName;
  final double categoryItemLat;
  final double categoryItemLng;

  @override
  State<CategoryItemShowOnMap> createState() => _CategoryItemShowOnMapState();
}

class _CategoryItemShowOnMapState extends State<CategoryItemShowOnMap> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  LatLng? _lastMapPosition;

  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googleApiKey);
  List<PlacesSearchResult> _placesSearchResult = [];

  List<LatLng> polylineCoordinates = [];
  final Set<Marker> _markers = {};
  LatLng? _currentLatLng;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onTravelButtonPressed(BuildContext context, String place) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                ),
                label: 'Details',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Pricing',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) {
                    return TravelForm(
                      place: place,
                    );
                  },
                );

              case 1:
                return CupertinoTabView(
                  builder: (context) {
                    return const Center(
                        child: Text(
                      "Pricing",
                      style: TextStyle(fontSize: 32),
                    ));
                  },
                );

              case 2:
                return CupertinoTabView(
                  builder: (context) {
                    return const Center(
                        child: Text(
                      "Settings",
                      style: TextStyle(fontSize: 32),
                    ));
                  },
                );

              default:
                return CupertinoTabView(
                  builder: (context) {
                    return const Text("Details");
                  },
                );
            }
          },
        );
      },
    );
  }

  void _onExploreButtonPressed() {
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void setCurrentLocation() {
    // Set currentLocation
    Geolocator.getCurrentPosition().then((currentLoc) {
      setState(() {
        _currentLatLng = LatLng(currentLoc.latitude, currentLoc.longitude);
        _markers.addAll([
          Marker(
            markerId: const MarkerId("currentLoc"),
            position: LatLng(currentLoc.latitude, currentLoc.longitude),
            infoWindow: const InfoWindow(
              title: "Me",
              snippet: "Here I am!",
            ),
          ),
        ]);
        if (_currentLatLng != null) {
          getPolyPoints(
            _currentLatLng!,
            LatLng(widget.categoryItemLat, widget.categoryItemLng),
          );
        }
      });
    });
  }

  void initMarker() {
    _markers.add(
      Marker(
        markerId: MarkerId("${widget.categoryItemLat}"),
        position: LatLng(widget.categoryItemLat, widget.categoryItemLng),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: widget.categoryName),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryItemDetails(
                place: Place(
                  lat: widget.categoryItemLat,
                  lng: widget.categoryItemLng,
                  placeName: widget.categoryName,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    getProximities(
      LatLng(widget.categoryItemLat, widget.categoryItemLng),
    );
    initMarker();

    // Mark the currentLoc
    setCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _currentLatLng == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff7c94b6),
                        ),
                        child: FractionallySizedBox(
                          heightFactor: 1,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  widget.categoryItemLat,
                                  widget.categoryItemLng,
                                ),
                                zoom: 11.0),
                            polylines: {
                              Polyline(
                                polylineId: const PolylineId("route"),
                                points: polylineCoordinates,
                                color: Colors.blue,
                                width: 6,
                              ),
                            },
                            markers: _markers,
                            onMapCreated: (mapController) {
                              _controller.complete(mapController);
                            },
                            onCameraMove: _onCameraMove,
                            mapType: _currentMapType,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          getProportionateScreenWidth(16.0),
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              ReusableFab(
                                onPressed: _onExploreButtonPressed,
                                icon: Icons.explore_sharp,
                              ),
                              ReusableFab(
                                onPressed: _onMapTypeButtonPressed,
                                icon: Icons.map,
                              ),
                              ReusableFab(
                                icon: Icons.radar,
                                onPressed: () => _onTravelButtonPressed(
                                  context,
                                  widget.categoryName,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Expanded(
            flex: 1,
            child: _currentLatLng == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Card(
                    elevation: 14.0,
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            "Places you might visit",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            width: double.infinity,
                            height: 295.0,
                            child: ListView.builder(
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(
                                      getProportionateScreenHeight(8.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenHeight(8.0),
                                        ),
                                        color: tPrimaryColor,
                                      ),
                                      child: _buildListTile(index),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(int index) {
    return ListTile(
      leading: const Icon(
        Icons.place,
        color: Colors.white,
      ),
      title: Text(
        "Lorem Ipsum($index)",
        style: TextStyle(
          fontSize: getProportionateScreenHeight(18),
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        "#45345...",
        style: TextStyle(
          fontSize: getProportionateScreenHeight(16),
        ),
      ),
      dense: true,
      isThreeLine: true,
      trailing: const Icon(
        Icons.tour,
        color: Colors.white,
      ),
      onTap: () => _onTravelButtonPressed(
        context,
        index.toString(),
      ),
    );
  }

  void getProximities(LatLng itemPosition) async {
    final location =
        Location(lat: itemPosition.latitude, lng: itemPosition.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      _placesSearchResult = result.results;
      if (_placesSearchResult.isNotEmpty) {
        _placesSearchResult.forEach((place) {
          _markers.add(
            Marker(
              markerId: MarkerId(place.placeId),
              position: LatLng(
                place.geometry!.location.lat,
                place.geometry!.location.lng,
              ),
              infoWindow:
                  InfoWindow(title: place.name, snippet: place.types.first),
              draggable: false,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan),
              onTap: () {
                _onTravelButtonPressed(context, place.name);
              },
            ),
          );
        });
      }
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
}
