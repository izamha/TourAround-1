class Package {
  int? packageId;
  final String packageName;
  final String packagePrice;
  final String desc;
  DateTime? createdAt;

  static int _idCounter = 0;
  static final DateTime _toDay = DateTime.now();

  Package({
    this.packageId = 0,
    required this.packageName,
    required this.packagePrice,
    required this.desc,
    this.createdAt,
  }) {
    _idCounter++;
    packageId = _idCounter;
    createdAt = _toDay;
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      packageId: map['packageId'],
      packageName: map['packageName'],
      packagePrice: map['packagePrice'],
      desc: map['desc'],
      createdAt: map['createdAt'],
    );
  }
}
