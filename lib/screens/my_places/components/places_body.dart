import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tour_around/repository/place_repository.dart';
import '../../../models/place.dart';

class PlacesBody extends StatefulWidget {
  const PlacesBody({Key? key}) : super(key: key);

  @override
  State<PlacesBody> createState() => _PlacesBodyState();
}

class _PlacesBodyState extends State<PlacesBody> {
  final PlaceRepository placeRepo = PlaceRepository();
  Place? placeInfo;

  void getPlacesInfo() async {
    placeInfo = await placeRepo.getPlaces();
  }

  @override
  void initState() {
    getPlacesInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: placeInfo == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    placeInfo!.placeName,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .23,
                  child: PhotoViewGallery.builder(
                    itemCount: placeInfo!.placeImageUrls!.length,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                          placeInfo!.placeImageUrls![index],
                        ),
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: placeInfo!.placeImageUrls![index].toString(),
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Latitude: ${placeInfo!.lat}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Longitude: ${placeInfo!.lng}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Added By: ${placeInfo!.lng}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Posted By: ${placeInfo!.postedBy}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Created On: ${placeInfo!.createdAt}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Approve"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
