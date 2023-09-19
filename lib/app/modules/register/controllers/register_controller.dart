import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/services/auth/auth_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/app_dialog.dart';

class RegisterController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  UserRepository userRepository = Get.find<UserRepository>();
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

  final _isHidePasswordConfirm = true.obs;

  bool get isHidePasswordConfirm => _isHidePasswordConfirm.value;

  set isHidePasswordConfirm(value) {
    _isHidePasswordConfirm.value = value;
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

  void onTapHidePasswordConfirm() {
    _isHidePasswordConfirm.toggle();
  }

  void onEmailAndPasswordRegister() async {
    isLoading = true;
    try {
      UserCredential userCredential = await authService
          .signUpWithEmailAndPassword(emailTEC.text, passwordTEC.text);
      User user = userCredential.user!;
      UserModel userModel = UserModel(
          id: user.uid ?? "",
          displayName: user.displayName ?? nameTEC.text,
          email: user.email ?? "",
          photoUrl: user.photoURL ?? "",
          active: true,
          accessToken: userCredential.credential?.accessToken ?? "");

      await userRepository.addNewUser(userModel);

      isLoading = false;
      Fluttertoast.showToast(
        msg: "Login Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      isLoading = false;
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AppDialog(
              title: "Auth Error",
              desc: e.toString(),
              type: DialogType.error,
            );
          });
    }
  }

  void onGoogleLogin() async {
    isLoading = true;
    try {
      UserCredential userCredential = await authService.signInWithGoogle();
      addUserOnFireStore(userCredential);
    } catch (e) {
      print(e.toString());
      isLoading = false;
    }
  }

  void onAppleLogin() async {
    isLoading = true;
    try {
      UserCredential userCredential = await authService.signInWithApple();
      addUserOnFireStore(userCredential);
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AppDialog(
              title: "Auth Error",
              desc: e.toString(),
              type: DialogType.error,
            );
          });
      isLoading = false;
    }
  }

  void onFacebookLogin() async {
    isLoading = true;
    try {
      UserCredential userCredential = await authService.signInWithFacebook();
      addUserOnFireStore(userCredential);
    } catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AppDialog(
              title: "Auth Error",
              desc: e.toString(),
              type: DialogType.error,
            );
          });
      isLoading = false;
    }
  }

  void addUserOnFireStore(UserCredential userCredential) async {
    User user = userCredential.user!;

    UserModel userModel = UserModel(
        id: user.uid ?? "",
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        photoUrl: user.photoURL ?? "",
        active: true,
        accessToken: userCredential.credential?.accessToken ?? "");

    await userRepository.addNewUser(userModel);

    isLoading = false;
    Fluttertoast.showToast(
      msg: "Login Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    Get.offAllNamed(Routes.HOME);
  }
}
