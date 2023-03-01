import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference reference =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> uploadFiles(List<File> images) async {
    var imageUrls = await Future.wait(
      images.map(
        (images) => uploadFile(images),
      ),
    );
    return imageUrls;
  }

  Future<String> uploadFile(File image) async {
    Reference reference = _storage.ref().child('place/images/$image');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
