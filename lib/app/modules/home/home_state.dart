import 'package:get/get.dart';

class HomeState {
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