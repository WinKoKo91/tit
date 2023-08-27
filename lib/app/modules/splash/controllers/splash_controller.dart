import 'package:get/get.dart';
import 'package:tit/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final logoOpacity = 0.0.obs;

  @override
  void onInit() {
    print("Splash");
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(Duration(milliseconds: 800), () {
      logoOpacity.value = 1;
    });

    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.ONBOARDING);
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
