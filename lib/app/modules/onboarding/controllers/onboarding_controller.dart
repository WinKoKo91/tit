import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/config_service.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';

import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  @override
  void onInit() {
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


  onNextPage() async{
    await ConfigService.to.saveFirstTimeOpen();
    Get.offNamed(Routes.HOME);
  }
}
