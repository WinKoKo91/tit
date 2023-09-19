import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tit/app/core/utils/permission_service.dart';
import 'package:tit/app/widgets/app_dialog.dart';

import 'image_picker_util.dart';

class PermissionHandler extends PermissionService {
  Future<bool> handleImageUploadPermissions(ImageSource? imageSource) async {
    if (imageSource == null) {
      return false;
    }
    if (imageSource == ImageSource.camera) {
      return await handleCameraPermission();
    } else if (imageSource == ImageSource.gallery) {
      return await handleGalleryPermission();
    } else {
      return false;
    }
  }

  Future<bool> handleGalleryPermission() async {
    return Platform.isAndroid
        ? await handleGalleryPermissionAndroid()
        : await handlePhotosPermission();
  }

  Future<bool> handleGalleryPermissionAndroid() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidVersion = await deviceInfoPlugin.androidInfo;
    if (androidVersion.version.sdkInt < 33) {
      return await handleStoragePermission();
    } else {
      return await handlePhotosPermission();
    }
  }

  @override
  Future<bool> handleCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: Get.context!,
        builder: (_) => AppDialog(
          title: 'Camera Permission',
          desc:
              'Camera should be granted to use this feature, would you like to go to app settings to give Camera permission?',
          type: DialogType.fail,
          buttonText: 'Settings',
          onPressed: () async {
            await openAppSettings().then((value) => print('result: $value'));
          },
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission() async {
    PermissionStatus photosPermissionStatus = await Permission.photos.request();
    print("photoPermissionStatus: $photosPermissionStatus");
    if (photosPermissionStatus == PermissionStatus.limited) {
      await showDialog(
        context: Get.context!,
        builder: (_) => AppDialog(
          title: 'Photos Permission',
          desc:
              'Photos should be granted to use this feature, would you like to go to app settings to give Photos permission?',
          type: DialogType.fail,
          buttonText: 'Settings',
          onPressed: () async {
            await openAppSettings().then((value) {
              print('result: $value');
            });
          },
        ),
      );
      return false;
    } else if (photosPermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: Get.context!,
        builder: (_) => AppDialog(
          title: 'Photos Permission',
          desc:
              'Photos should be granted to use this feature, would you like to go to app settings to give Photos permission?',
          type: DialogType.fail,
          buttonText: 'Settings',
          onPressed: () async {
            await openAppSettings().then((value) {
              print('result: $value');
            });
          },
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Future<bool> handleStoragePermission() async {
    PermissionStatus storagePermissionStatus =
        await Permission.storage.request();

    if (storagePermissionStatus != PermissionStatus.granted) {
      await showDialog(
        context: Get.context!,
        builder: (_) => AppDialog(
          title: 'Storage Permission',
          desc:
              'Storage should be granted to use this feature, would you like to go to app settings to give Storage permission?',
          type: DialogType.fail,
          buttonText: 'Settings',
          onPressed: () async {
            await openAppSettings().then((value) => print('result: $value'));
          },
        ),
      );
      return false;
    }
    return true;
  }
}
