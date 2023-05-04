import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tour_around/models/package.dart';
import 'package:tour_around/screens/sign_up/utils/auth_methods.dart';

class NewPackageMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new Package
  Future<String> createNewPackage({
    required String packageName,
    required String packagePrice,
    required String packageDesc,
  }) async {
    String response = "Error";
    final userInfo = await AuthMethods().getUserInfo();

    try {
      if (packageName.isNotEmpty ||
          packagePrice.isNotEmpty ||
          packageDesc.isNotEmpty) {
        // Use the model
        Package newPackage = Package(
          packageName: packageName,
          packagePrice: packagePrice,
          desc: packageDesc,
          postedBy: userInfo.username,
        );

        // Save to Firestore
        await _firestore.collection("packages").add(
              newPackage.toJson(),
            );
        response = "Success";
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}
