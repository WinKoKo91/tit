import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_image_widget.dart';

class ImagePickerContentWidget extends StatelessWidget {
  const ImagePickerContentWidget({
    Key? key,
    required this.onTakePhoto,
    required this.onUploadImage,
  }) : super(key: key);
  final VoidCallback onTakePhoto, onUploadImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text(
            'Take Photo',
          ),
          onTap: onTakePhoto,
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text(
            'Gallery',
          ),
          onTap: onUploadImage,
        )
      ],
    );
  }
}

