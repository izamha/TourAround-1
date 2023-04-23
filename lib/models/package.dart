import 'package:cloud_firestore/cloud_firestore.dart';

class Package {
  int? packageId;
  final String packageName;
  final String packagePrice;
  final String desc;
  DateTime? createdAt;
  final String? postedBy;
  String? referenceId;
  int? visitors;

  static int _idCounter = 0;
  static final DateTime _toDay = DateTime.now();

  Package({
    this.packageId = 0,
    required this.packageName,
    required this.packagePrice,
    required this.desc,
    this.createdAt,
    this.postedBy,
    this.referenceId,
    this.visitors = 1,
  }) {
    _idCounter++;
    packageId = _idCounter;
    createdAt = _toDay;
  }

  factory Package.fromSnapshot(DocumentSnapshot snapshot) {
    final newPackage =
        Package.fromJson(snapshot.data() as Map<String, dynamic>);
    newPackage.referenceId = snapshot.reference.id;
    return newPackage;
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      packageId: map['packageId'],
      packageName: map['packageName'],
      packagePrice: map['packagePrice'],
      desc: map['packageDesc'],
      postedBy: map['postedBy'],
      visitors: map['visitors'],
      // createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "packageName": packageName,
        "packagePrice": packagePrice,
        "packageDesc": desc,
        "postedBy": postedBy,
        "visitors": visitors,
      };

  static Package fromJson(Map<String, dynamic> json) => Package(
        packageName: json['packageName'],
        packagePrice: json['packagePrice'],
        desc: json['packageDesc'],
        postedBy: json['postedBy'],
        visitors: json['visitors'],
        // createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
