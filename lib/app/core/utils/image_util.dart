import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUtil {
  static Future<String> cropImage({
    required String path,
    bool isNrc = false,
  }) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: isNrc
          ? [CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9]
          : [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
      compressQuality: 60,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Get.theme.colorScheme.secondary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    return croppedFile?.path ?? ' ';
  }

  static Uint8List readToBytes(File file) {
    return file.readAsBytesSync();
  }

  static String pathToBase64({required String path}) {
    final bytes = File(path).readAsBytesSync();

    return base64Encode(bytes);
  }

  static Future<String> compressImage({required String path}) async {
    final result = await FlutterImageCompress.compressWithFile(
      path,
      quality: 80,
    );
    return base64Encode(result!);
  }

  static double checkImageSize({required String path}) {
    final bytes = File(path).readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb.roundToDouble();
  }
}
