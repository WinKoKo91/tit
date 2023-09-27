import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tit/app/data/models/person_model.dart';
import 'package:tit/app/data/models/user_model.dart';

import '../../../data/repositories/person_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../routes/app_pages.dart';

class QrScannerController extends GetxController {
  PersonRepository personRepository = Get.find<PersonRepository>();
  UserRepository userRepository = Get.find<UserRepository>();

  Barcode? result;
  QRViewController? qrController;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final _hasPermission = true.obs;

  bool get hasPermission => _hasPermission.value;

  set hasPermission(value) {
    _hasPermission.value = value;
  }

  @override
  void onInit() {
    getCameraPermission();
    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code!.isNotEmpty) {
        qrController!.pauseCamera();
        PersonModel? personModel =
            await personRepository.checkPerson(scanData.code ?? "");
        if (personModel != null) {
          UserModel? userModel = await userRepository.getUser();

          if (personModel.id == userModel!.id!) {
            Get.showSnackbar(const GetSnackBar(message: "Data not correct"))
                .show();
            return;
          }
          // Add Person in your data
          await personRepository.addPerson(userModel!.id!, personModel);
          // Add your data in person
          await personRepository.addPerson(personModel.id!,
              PersonModel.convertEntityToPersonModel(userModel));

          Get.showSnackbar(
                  const GetSnackBar(title: "Success", message: "Contact Added"))
              .show();
          Get.offAllNamed(Routes.MAIN, arguments: true);
        } else {
          Get.showSnackbar(const GetSnackBar(message: "Data not correct"))
              .show();
        }
      }
    });
  }

  void getCameraPermission() async {
    var status = await Permission.camera.request();

    if (status.isDenied) {
      Get.back();
    } else if (status.isPermanentlyDenied) {
      /*showCustomDialog(
          title: "Enable Camera Permission",
          desc: "Need camera permission to process QR scanner.",
          dialogType: DialogType.fail,
          positiveButtonText: "Go to Setting",
          negativeButtonText: "Cancel",
          onPressedConfirm: () {
            openPermissionSettings();
          },
          onPressedCancel: () {
            Get.back();
          });*/
    } else {
      hasPermission = true;
    }
  }

  Future<void> openPermissionSettings() async {
    bool isOpened = await openAppSettings();
    if (!isOpened) {
      throw 'Could not open app settings.';
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
