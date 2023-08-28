import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();
  final confirmPasswordTEC = TextEditingController();
  final nameTEC = TextEditingController();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  final _isHidePassword = true.obs;

  bool get isHidePassword => _isHidePassword.value;

  set isHidePassword(value) {
    _isHidePassword.value = value;
  }

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
    nameTEC.dispose();
    emailTEC.dispose();
    passwordTEC.dispose();
    confirmPasswordTEC.dispose();

    super.onClose();
  }

  void onTapHidePassword() {
    _isHidePassword.toggle();
  }

  void onRegister() {}
}
