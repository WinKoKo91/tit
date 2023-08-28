import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../core/services/auth/auth_service.dart';
import '../../../data/repositories/user_repository.dart';

class HomeController extends GetxController {

  UserRepository userRepository = Get.find<UserRepository>();
  final _user = Rxn<UserEntity>();

  UserEntity? get user => _user.value;

  set user(value) {
    _user.value = value;
  }

  @override
  void onInit() async {
    //user = UserEntity();
    user = await userRepository.getUser();
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

    await userRepository.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
