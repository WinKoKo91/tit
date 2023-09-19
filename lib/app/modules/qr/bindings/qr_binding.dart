import 'package:get/get.dart';

import '../controllers/qr_controller.dart';

class QrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrController>(
      () => QrController(),
    );
  }
}
