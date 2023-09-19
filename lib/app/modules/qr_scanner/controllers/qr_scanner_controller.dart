import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerController extends GetxController {

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

    controller.scannedDataStream.listen((scanData) {
      if (scanData.code!.isNotEmpty) {
        qrController!.pauseCamera();
        //TODO : task
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
