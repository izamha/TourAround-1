// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../constants/colors.dart';
// import '../../constants/size_config.dart';
// import '../../constants/theme.dart';
// import '../../screens/home/components/show_images.dart';
// import '../custom_snackbar.dart';
// import '../custom_suffix_icon.dart';

// class AddPlaceDialog extends StatefulWidget {
//   const AddPlaceDialog({super.key});

//   @override
//   State<AddPlaceDialog> createState() => _AddPlaceDialogState();
// }

// class _AddPlaceDialogState extends State<AddPlaceDialog> {
//   List<File>? imageFileList = [];
//   final ImagePicker _imagePicker = ImagePicker();

//   final TextEditingController _placeNameController = TextEditingController();
//   final TextEditingController _placeUrlController = TextEditingController();
//   final TextEditingController _placeDescController = TextEditingController();

//   void addNewPlace(LatLng position) async {
//     String response = await NewPlaceMethods().createNewPlace(
//       placeName: _placeNameController.text,
//       url: _placeUrlController.text,
//       placeDesc: _placeDescController.text,
//       placeLat: position.latitude,
//       placeLng: position.longitude,
//       placeImageUrl: imageFileList,
//     );

//     _isLoading = true;

//     if (response != "Success") {
//       Future.delayed(Duration.zero).then(
//         (value) {
//           CustomSnackbar(
//             snackTitle: "Error",
//             text: response,
//           );
//         },
//       );
//     } else {
//       Future.delayed(Duration.zero).then(
//         (value) {
//           const CustomSnackbar(
//             snackTitle: "Success",
//             text: "Successfully saved!",
//           );
//         },
//       );
//     }
//   }

//   void selectImages() async {
//     final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
//     if (selectedImages.isNotEmpty) {
//       for (var image in selectedImages) {
//         setState(() {
//           imageFileList!.add(
//             File(image.path),
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Add a Place"),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             imageFileList!.isEmpty
//                 ? Stack(
//                     children: [
//                       Card(
//                         semanticContainer: true,
//                         clipBehavior: Clip.antiAlias,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 2,
//                         margin: const EdgeInsets.all(10),
//                         child: Image.asset(
//                           'assets/images/image-placeholder.jpg',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: -3,
//                         child: SizedBox(
//                           height: 46,
//                           width: 46,
//                           child: TextButton(
//                             style: flatRoundButtonStyle,
//                             onPressed: selectImages,
//                             child: SvgPicture.asset(
//                                 "assets/icons/camera-icon.svg"),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : SizedBox(
//                     height: MediaQuery.of(context).size.height * .24,
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: tScaffoldBgColor,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(
//                                 getProportionateScreenWidth(5),
//                               ),
//                             ),
//                           ),
//                           width: MediaQuery.of(context).size.width * .8,
//                           child: GridView.builder(
//                               itemCount: imageFileList!.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                                 crossAxisSpacing: 5,
//                                 mainAxisSpacing: 5,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return ShowImage(
//                                   imageFileList: imageFileList,
//                                   index: index,
//                                 );
//                               }),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: -12,
//                           child: SizedBox(
//                             height: 46,
//                             width: 46,
//                             child: TextButton(
//                               style: flatRoundButtonStyle,
//                               onPressed: selectImages,
//                               child: SvgPicture.asset(
//                                 "assets/icons/camera-icon.svg",
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//             SizedBox(
//               height: getProportionateScreenHeight(30),
//             ),
//             buildAddPlaceForm(position),
//           ],
//         ),
//       ),
//     );
//   }

//   Form buildAddPlaceForm(LatLng position) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.warning_amber),
//               RichText(
//                 text: TextSpan(
//                   text: 'Lat and Lng shall be auto-saved.',
//                   style: DefaultTextStyle.of(context).style,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: getProportionateScreenHeight(20),
//           ),
//           buildPlaceNameFormField(),
//           SizedBox(
//             height: getProportionateScreenHeight(30),
//           ),
//           buildUrlFormField(),
//           SizedBox(
//             height: getProportionateScreenHeight(30),
//           ),
//           buildLatFormField(position),
//           buildLngFormField(position),
//           buildPlaceDescFormField(),
//         ],
//       ),
//     );
//   }

//   TextFormField buildUrlFormField() {
//     return TextFormField(
//       controller: _placeUrlController,
//       keyboardType: TextInputType.url,
//       decoration: const InputDecoration(
//         labelText: "URL",
//         hintText: "Link to place",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/location.svg"),
//         suffixIconColor: tPrimaryColor,
//       ),
//     );
//   }

//   TextFormField buildPlaceDescFormField() {
//     return TextFormField(
//       controller: _placeDescController,
//       decoration: const InputDecoration(
//         labelText: "Place Description",
//         hintText: "Place Descriptions",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/pen.svg"),
//         suffixIconColor: tPrimaryColor,
//       ),
//       minLines: 1,
//       maxLines: 3,
//       maxLength: 140,
//     );
//   }

//   Visibility buildLngFormField(LatLng position) {
//     return Visibility(
//       visible: false,
//       child: TextFormField(
//         // controller: _lngNameController,
//         initialValue: "${position.longitude}",
//         enabled: false,
//         decoration: const InputDecoration(
//           labelText: "Longitude",
//           suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location.svg"),
//         ),
//       ),
//     );
//   }

//   Visibility buildLatFormField(LatLng position) {
//     return Visibility(
//       visible: false,
//       child: TextFormField(
//         // controller: _latController,
//         enabled: false,
//         initialValue: "${position.latitude}",
//         decoration: const InputDecoration(
//           labelText: "Latitude",
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Location.svg"),
//           suffixIconColor: tPrimaryColor,
//         ),
//       ),
//     );
//   }

//   TextFormField buildPlaceNameFormField() {
//     return TextFormField(
//       controller: _placeNameController,
//       decoration: const InputDecoration(
//         labelText: "Place Name",
//         hintText: "My New Place",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/pen.svg"),
//         suffixIconColor: tPrimaryColor,
//       ),
//     );
//   }
// }
