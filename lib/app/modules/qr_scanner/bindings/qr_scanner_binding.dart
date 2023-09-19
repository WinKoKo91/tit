import 'package:get/get.dart';

import '../controllers/qr_scanner_controller.dart';

class QrScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrScannerController>(
      () => QrScannerController(),
    );
  }
}
