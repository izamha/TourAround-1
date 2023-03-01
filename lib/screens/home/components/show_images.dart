import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({
    Key? key,
    required this.imageFileList,
    required this.index,
  }) : super(key: key);

  final List<File>? imageFileList;
  final int index;

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(widget.imageFileList![widget.index].path),
      fit: BoxFit.cover,
    );
  }
}
