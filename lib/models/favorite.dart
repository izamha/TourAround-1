import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_around/models/place.dart';
import 'package:tour_around/models/user.dart';

class Favorite {
  final Place place;
  final User user;

  Favorite({
    required this.place,
    required this.user,
  });

  factory Favorite.fromSnapshot(DocumentSnapshot snapshot) {
    final fav = Favorite.fromJson(snapshot.data() as Map<String, dynamic>);
    return fav;
  }

  Map<String, dynamic> toJson() => {"place": place, "user": user};

  static Favorite fromJson(Map<String, dynamic> json) => Favorite(
        place: json['place'],
        user: json['user'],
      );
}
