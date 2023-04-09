import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tour_around/constants/colors.dart';
import 'package:tour_around/constants/size_config.dart';
import 'package:tour_around/models/place.dart';
import 'package:tour_around/repository/place_repository.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';
import 'package:tour_around/screens/sign_up/utils/show_dialog.dart';
import 'package:tour_around/utils/new_place_methods.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/expandable_card.dart';
import '../../../constants/theme.dart';
import 'no_data_yet.dart';

class PlacesBodyNew extends StatefulWidget {
  const PlacesBodyNew({Key? key}) : super(key: key);

  @override
  State<PlacesBodyNew> createState() => _PlacesBodyNewState();
}

class _PlacesBodyNewState extends State<PlacesBodyNew> {
  TextEditingController _placeNameController = TextEditingController();
  TextEditingController _placeDescController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  final _formKey = GlobalKey<FormState>();

  final PlaceRepository placeRepo = PlaceRepository();

  bool isExpanded = false;
  DocumentSnapshot? snapshot;
  String userType = "";
  String userName = "";
  List<File>? imageFileList = [];
  final ImagePicker _imagePicker = ImagePicker();

  void retrieveUserInfo() async {
    snapshot = await AuthMethods().getUserInfoTwo();

    setState(() {
      userName = snapshot!['username'];
      userType = snapshot!['userType'];
    });
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

  @override
  void initState() {
    retrieveUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: placeRepo.getStream(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: tPrimaryColor,
              ),
            );
          }
          if (snapshot.data!.size == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/no_data.svg",
                    width: 250,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  const Text(
                    "No places available.",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
          return _buildList(context, snapshot.data?.docs ?? []);
        }),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, List<QueryDocumentSnapshot<Object?>> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final place = Place.fromSnapshot(snapshot);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE6E6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            // const Spacer(),
            SvgPicture.asset("assets/icons/trash.svg"),
          ],
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          placeRepo.deletePlace(snapshot.id, context);
        });
      },
      child: place.postedBy == userName
          ? Stack(
              children: [
                SizedBox(
                  height: userType == 'Admin'
                      ? (isExpanded
                          ? getProportionateScreenHeight(380)
                          : getProportionateScreenHeight(350))
                      : isExpanded
                          ? getProportionateScreenHeight(380)
                          : getProportionateScreenHeight(346),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.lightGreen.shade50,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.height * .32,
                              height: MediaQuery.of(context).size.height * .23,
                              child: PhotoViewGallery.builder(
                                itemCount: place.placeImageUrls!.length,
                                builder: (BuildContext context, int index) {
                                  return PhotoViewGalleryPageOptions(
                                    imageProvider: NetworkImage(
                                      place.placeImageUrls![index],
                                    ),
                                    initialScale:
                                        PhotoViewComputedScale.contained * .9,
                                    heroAttributes: PhotoViewHeroAttributes(
                                      tag: place.placeImageUrls![index]
                                          .toString(),
                                    ),
                                  );
                                },
                                loadingBuilder: (context, event) => Center(
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      value: event == null
                                          ? 0
                                          : event.cumulativeBytesLoaded /
                                              event.expectedTotalBytes!,
                                    ),
                                  ),
                                ),
                                backgroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  place.placeName,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  NewPlaceMethods()
                                      .formatDate(place.createdAt!),
                                  style: const TextStyle(color: tPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          ExpandableCard(
                            expandedChild: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0, right: 8.0),
                                  child: SizedBox(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                      child: Text(
                                        place.placeDesc!,
                                        maxLines: 3,
                                        softWrap: true,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            collapsedChild: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(8.0),
                                    top: getProportionateScreenWidth(8.0),
                                    right: getProportionateScreenWidth(8.0),
                                  ),
                                  child: SizedBox(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                      child: Text(
                                        place.placeDesc!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: true,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isExpanded: isExpanded,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: getProportionateScreenWidth(8.0),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  // Update a place
                                  placeRepo.updatePlace(
                                      'isVisible', true, snapshot);
                                },
                                child: userType == 'Admin'
                                    ? ((place.isVisible!)
                                        ? const Text(
                                            "Disapprove",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 60, 0)),
                                          )
                                        : const Text("Approve"))
                                    : const Text(""),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                (place.postedBy == userName || userType == 'Admin')
                    ? Positioned(
                        top: 0,
                        right: -3,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: flatRoundButtonStyle,
                            onPressed: () {
                              showCustomizableDialog(
                                context,
                                const Text("Update Place"),
                                buildDialogContent(context, place, snapshot),
                                "Update",
                                () async {
                                  await FirebaseFirestore.instance
                                      .collection("places")
                                      .doc(snapshot.id)
                                      .update({
                                    'placeName': _placeNameController.text,
                                    'lat': double.parse(_latController.text),
                                    'lng': double.parse(_lngController.text),
                                    'placeDesc': _placeDescController.text,
                                  });
                                  Future.delayed(Duration.zero).then(
                                    (value) => Navigator.pop(context, 'Cancel'),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              color: tPrimaryColor,
                            ),
                          ),
                        ),
                      )
                    : Visibility(
                        visible: true,
                        child: Positioned(
                          top: 0,
                          right: -3,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: TextButton(
                              style: flatRoundButtonStyle,
                              onPressed: () {
                                showCustomizableDialog(
                                  context,
                                  const Text("Update Place"),
                                  buildDialogContent(context, place, snapshot),
                                  "Update",
                                  () async {
                                    await FirebaseFirestore.instance
                                        .collection("places")
                                        .doc(snapshot.id)
                                        .update({
                                      'placeName': _placeNameController.text,
                                      'lat': double.parse(_latController.text),
                                      'lng': double.parse(_lngController.text),
                                      'placeDesc': _placeDescController.text,
                                    });
                                    Future.delayed(Duration.zero).then(
                                      (value) =>
                                          Navigator.pop(context, 'Cancel'),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                color: tPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            )
          : const NoDataYet(dataName: "places"),
    );
  }

  SingleChildScrollView buildDialogContent(
    BuildContext context,
    Place place,
    DocumentSnapshot snapshot,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          place.placeImageUrls!.isEmpty
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
                          child:
                              SvgPicture.asset("assets/icons/camera-icon.svg"),
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
                        width: MediaQuery.of(context).size.width * .8,
                        child: GridView.builder(
                            itemCount: place.placeImageUrls!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return Image.network(
                                place.placeImageUrls![index],
                                fit: BoxFit.cover,
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
                              "assets/icons/camera-icon.svg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildAddPlaceForm(place),
        ],
      ),
    );
  }

  Form buildAddPlaceForm(Place place) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          buildPlaceNameFormField(place),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildLatFormField(place),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildLngFormField(place),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPlaceDescFormField(place),
        ],
      ),
    );
  }

  TextFormField buildLngFormField(Place place) {
    setState(() {
      _lngController = TextEditingController(text: "${place.lng}");
    });
    return TextFormField(
      controller: _lngController,
      enabled: false,
      decoration: const InputDecoration(
        labelText: "Longitude",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location.svg"),
      ),
    );
  }

  TextFormField buildLatFormField(Place place) {
    setState(() {
      _latController = TextEditingController(text: "${place.lat}");
    });
    return TextFormField(
      controller: _latController,
      enabled: true,
      decoration: const InputDecoration(
        labelText: "Latitude",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location.svg"),
        suffixIconColor: tPrimaryColor,
      ),
    );
  }

  TextFormField buildPlaceNameFormField(Place place) {
    setState(() {
      _placeNameController = TextEditingController(text: place.placeName);
    });
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

  TextFormField buildPlaceDescFormField(Place place) {
    setState(() {
      _placeDescController = TextEditingController(text: place.placeDesc);
    });
    return TextFormField(
      controller: _placeDescController,
      decoration: const InputDecoration(
        labelText: "Place Description",
        hintText: "Descriptions",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/pen.svg"),
        suffixIconColor: tPrimaryColor,
      ),
      minLines: 1,
      maxLines: 3,
      maxLength: 140,
    );
  }
}
