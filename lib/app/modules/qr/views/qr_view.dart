import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tit/app/core/src/app_spacing.dart';

import '../controllers/qr_controller.dart';

class QrView extends GetView<QrController> {
  const QrView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR Code'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(AppSpacing.xl.h),
        width: double.infinity,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
              top: AppSpacing.x2l.h,
              bottom: AppSpacing.x2l.h,
            ),
            child: const Text(
              "Let your friends scan this QR Code to add your phone number",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            color: Colors.white,
            height: 400.h,
            padding: const EdgeInsets.all(AppSpacing.x6l),
            child: Obx(
              () => controller.userEntity == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : QrImageView(
                      data: controller.userEntity!.id!,
                      version: QrVersions.auto,
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
