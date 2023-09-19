import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tit/app/core/src/app_size.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../core/src/app_spacing.dart';
import '../controllers/qr_scanner_controller.dart';

class QrScannerView extends GetView<QrScannerController> {
  const QrScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.hasPermission
            ? Stack(
                children: [
                  QRView(
                    key: controller.qrKey,
                    onQRViewCreated: controller.onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      overlayColor: const Color.fromRGBO(0, 0, 0, 75),
                      borderRadius: 10.r,
                      borderLength: 30.h,
                      borderWidth: 10.w,
                      cutOutSize: 250.h,
                      cutOutBottomOffset: Get.height.h * 0.073.h,
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.x2l.h,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Text(
                          'Place the code in the center of the square. It will be scanned automatically.',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white)
                        ),
                        child: Text(
                          'My QR code',
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.QR);
                        },
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
