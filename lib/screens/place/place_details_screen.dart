import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tour_around/components/text_marquee_widget.dart';
import 'package:tour_around/constants/paddings.dart';
import 'package:tour_around/utils/weather_methods.dart';
import 'package:weather/weather.dart';
import '../../constants/colors.dart';
import '../../models/place.dart';
import '../../repository/place_repository.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const PlaceDetailsScreen({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tScaffoldBgColor,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: StatefulBody(
        place: place,
      ),
    );
  }
}

class StatefulBody extends StatefulWidget {
  const StatefulBody({
    Key? key,
    required this.place,
    this.initialIndex = 0,
    this.backgroundDecoration,
  }) : super(key: key);

  final Place place;
  final int initialIndex;
  final BoxDecoration? backgroundDecoration;

  @override
  State<StatefulBody> createState() => _StatefulBodyState();
}

class _StatefulBodyState extends State<StatefulBody> {
  @override
  Widget build(BuildContext context) {
    final Future<Weather> weather =
        Future<Weather>.delayed(const Duration(seconds: 2), () {
      return WeatherMethods().getWeather(widget.place.lat, widget.place.lng);
    });
    return RetrieveWeatherInfoWidget(weather: weather, widget: widget);
  }
}

class RetrieveWeatherInfoWidget extends StatefulWidget {
  const RetrieveWeatherInfoWidget({
    Key? key,
    this.weather,
    required this.widget,
  }) : super(key: key);

  final Future<Weather>? weather;
  final StatefulBody widget;

  @override
  State<RetrieveWeatherInfoWidget> createState() =>
      _RetrieveWeatherInfoWidgetState();
}

class _RetrieveWeatherInfoWidgetState extends State<RetrieveWeatherInfoWidget> {
  final PlaceRepository placeRepo = PlaceRepository();

  var _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Weather>(
        future: widget.weather, // a previously-obtained Future<Weather> or null
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .23,
                child: widget.widget.place.placeImageUrls == null
                    ? SvgPicture.asset("assets/images/no_data.svg")
                    : PhotoViewGallery.builder(
                        itemCount: widget.widget.place.placeImageUrls!.length,
                        builder: (BuildContext context, int index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(
                              widget.widget.place.placeImageUrls![index],
                            ),
                            initialScale:
                                PhotoViewComputedScale.contained * 0.9,
                            heroAttributes: PhotoViewHeroAttributes(
                              tag: widget.widget.place.placeImageUrls![index]
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextMarquee(
                                      direction: Axis.horizontal,
                                      child: Text(
                                        widget.widget.place.placeName,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLiked = !_isLiked;
                                          // placeRepo.updatePlace('isLiked', _isLiked);
                                        });
                                        // Update a place
                                        // placeRepo.updatePlace(
                                        //     'isVisible', true, snapshot); widget.widget.place.isLiked!
                                      },
                                      icon: _isLiked
                                          ? const Icon(
                                              Icons.favorite_outline,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              Icons.favorite,
                                              color: tPrimaryColor,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: Text(
                            widget.widget.place.placeDesc ??
                                'Place Descriptions',
                            style: const TextStyle(fontSize: 19),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          "Weather Info",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        ListTile(
                          title: const Text("Temperature"),
                          subtitle: Text("${snapshot.data!.tempFeelsLike}"),
                        ),
                        ListTile(
                          title: const Text("Humidity"),
                          subtitle: Text("${snapshot.data!.humidity}"),
                        ),
                        ListTile(
                          title: const Text("Max. Temp."),
                          subtitle: Text("${snapshot.data!.tempMax}"),
                        ),
                        const SizedBox(
                          height: defaultPadding * 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16),
              //   child: Text('Temp: ${snapshot.data!.temperature}'),
              // ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ];
          }
          return Column(
            children: children,
          );
        },
      ),
    );
  }
}
