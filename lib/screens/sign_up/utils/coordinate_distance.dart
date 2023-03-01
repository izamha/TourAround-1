import 'dart:math';

double distanceBetween(lat1, lng1, lat2, lng2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
  return (12742 * asin(sqrt(a))).floorToDouble();
}
