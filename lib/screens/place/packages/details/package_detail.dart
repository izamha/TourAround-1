import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tour_around/controllers/payment_controller.dart';
import 'package:tour_around/models/package.dart';
import 'package:weather/weather.dart';

import '../../../../components/text_marquee_widget.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/paddings.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({
    super.key,
    required this.package,
    this.weather,
  });

  final Package package;
  final Future<Weather>? weather;

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  final List<String> placeImageUrls = [];
  bool _isLiked = false;
  PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .23,
            child: placeImageUrls.isEmpty
                ? SvgPicture.asset("assets/images/no_data.svg")
                : PhotoViewGallery.builder(
                    itemCount: 4,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                          placeImageUrls[index],
                        ),
                        initialScale: PhotoViewComputedScale.contained * 0.9,
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: placeImageUrls[index].toString(),
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
          const SizedBox(
            height: defaultPadding * 1.5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultPadding * 3),
                  topRight: Radius.circular(defaultPadding * 3),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 375,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextMarquee(
                                  direction: Axis.horizontal,
                                  child: Text(
                                    widget.package.packageName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      splashColor: tPrimaryColor,
                                      onPressed: () {
                                        setState(() {
                                          // placeRepo.updatePlace('isLiked', _isLiked);
                                        });
                                        // Update a place
                                        // placeRepo.updatePlace(
                                        //     'isVisible', true, snapshot); widget.widget.place.isLiked!
                                      },
                                      icon: !_isLiked
                                          ? const Icon(
                                              Icons.favorite_outline,
                                              color: tPrimaryColor,
                                            )
                                          : const Icon(
                                              Icons.favorite,
                                              color: tPrimaryColor,
                                            ),
                                    ),
                                    IconButton(
                                      splashColor: tPrimaryColor,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share,
                                        color: tPrimaryColor,
                                      ),
                                    ),
                                    IconButton(
                                      splashColor: tPrimaryColor,
                                      onPressed: () =>
                                          paymentController.makePayment(
                                              amount:
                                                  widget.package.packagePrice,
                                              currency: 'USD'),
                                      icon: const Icon(
                                        Icons.payment,
                                        color: tPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Text(
                        'Elit sint proident do laboris. Eu laborum magna ea voluptate nostrud aute consectetur cupidatat in.Irure ut sunt quis in laborum excepteur exercitation veniam incididunt. Aute nisi sint proident fugiat elit.',
                        style: TextStyle(fontSize: 19),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: tPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSnacksDesc(),
                          _buildPeopleDesc(),
                          _buildPriceDesc(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Weather Info",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const ListTile(
                      title: Text("Temperature"),
                      subtitle: Text("0 Celcius"),
                    ),
                    const ListTile(
                      title: Text("Humidity"),
                      subtitle: Text("humidityVal"),
                    ),
                    const ListTile(
                      title: Text("Max. Temp."),
                      subtitle: Text("tempMax"),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Row _buildSnacksDesc() {
    return Row(
      children: const [
        Icon(
          Icons.check_circle_outline_outlined,
          color: tPrimaryColor,
        ),
        SizedBox(
          width: 2.0,
        ),
        Text(
          "Snacks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Row _buildPeopleDesc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(
          Icons.people_outline,
          color: tPrimaryColor,
        ),
        SizedBox(
          width: 2.0,
        ),
        Text(
          "People",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDesc() {
    return Row(
      children: [
        const Icon(
          Icons.sell_outlined,
          color: tPrimaryColor,
        ),
        const SizedBox(
          width: 2.0,
        ),
        Text(
          "\$${widget.package.packagePrice}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
