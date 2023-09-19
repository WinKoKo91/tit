import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperUtils {
  static Future<CroppedFile?> cropImage(File pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      maxWidth: 600,
      maxHeight: 600,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [androidUiSettings(), iosUiSettings()],
    );
    if (croppedFile != null) {
      return croppedFile;
    } else {
      return null;
    }
  }

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: false,
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Get.theme.primaryColor,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      );
}
