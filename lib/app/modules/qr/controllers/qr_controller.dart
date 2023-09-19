import 'package:get/get.dart';

import '../../../data/entities/user_entity.dart';
import '../../../data/repositories/user_repository.dart';

class QrController extends GetxController {
  UserRepository userRepository = Get.find<UserRepository>();
  final _userEntity = Rxn<UserEntity>();

  UserEntity? get userEntity => _userEntity.value;

  set userEntity(value) {
    _userEntity.value = value;
  }

  @override
  void onInit() async {
    userEntity = await userRepository.getUser();
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
}
