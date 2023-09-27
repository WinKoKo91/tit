import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/pages/people_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PeopleController>(
      () => PeopleController(),
    );
  }
}
