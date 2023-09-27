import 'package:get/get.dart';

import '../../../data/entities/user_entity.dart';

class SettingsState {

  final _userEntity = Rxn<UserEntity>();
  UserEntity? get userEntity => _userEntity.value;

  set userEntity(value) {
    _userEntity.value = value;
  }


  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  set isDarkMode(value) {
    _isDarkMode.value = value;
  }

  final _isNotificationOn = false.obs;

  bool get isNotificationOn => _isNotificationOn.value;

  set isNotificationOn(value) {
    _isNotificationOn.value = value;
  }
}