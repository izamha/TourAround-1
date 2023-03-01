import 'package:image_picker/image_picker.dart';

pickImages() async {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

  if (selectedImages!.isNotEmpty) {
    imageFileList.addAll(selectedImages);
  }
}
