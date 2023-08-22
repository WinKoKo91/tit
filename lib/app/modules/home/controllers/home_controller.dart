import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../core/services/auth_service.dart';

class HomeController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  late User user;
  @override
  void onInit() {
    user  = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void logout() async {
    await authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
