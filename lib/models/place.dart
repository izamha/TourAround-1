import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final double lat;
  final double lng;
  final String placeName;
  final String? url;
  final String? placeDesc;
  final List<String>? placeImageUrls;
  String? referenceId;
  final bool? isVisible, isLiked;
  final String? postedBy;
  final DateTime? createdAt;

  Place({
    required this.lat,
    required this.lng,
    required this.placeName,
    this.url,
    this.placeDesc,
    this.placeImageUrls,
    this.referenceId,
    this.isVisible = false,
    this.isLiked = false,
    this.postedBy,
    this.createdAt,
  });

  factory Place.fromSnapshot(DocumentSnapshot snapshot) {
    final newPlace = Place.fromJson(snapshot.data() as Map<String, dynamic>);
    newPlace.referenceId = snapshot.reference.id;
    return newPlace;
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "placeName": placeName,
        "url": url,
        "placeDesc": placeDesc,
        "placeImageUrls": placeImageUrls,
        "isVisible": isVisible,
        "isLiked": isLiked,
        "postedBy": postedBy,
        "createdAt": createdAt,
      };
  static Place fromJson(Map<String, dynamic> json) => Place(
        lat: json['lat'],
        lng: json['lng'],
        placeName: json['placeName'],
        url: json['url'],
        placeDesc: json['placeDesc'],
        placeImageUrls: (json['placeImageUrls'] as List)
            .map((item) => item as String)
            .toList(),
        isVisible: json['isVisible'],
        isLiked: json['isLiked'],
        postedBy: json['postedBy'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
