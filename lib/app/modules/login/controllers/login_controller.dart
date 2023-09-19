import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth/auth_service.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/routes/app_pages.dart';
import 'package:tit/app/widgets/app_dialog.dart';

import '../../../data/remote/firestore_user.dart';
import '../../../data/repositories/user_repository.dart';

class LoginController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  UserRepository userRepository = Get.find<UserRepository>();

  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();

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
    emailTEC.dispose();
    passwordTEC.dispose();
    super.onClose();
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

  void onEmailAndPasswordLogin() async {
    isLoading = true;
    try {
      UserCredential userCredential = await authService
          .signInWithEmailAndPassword(emailTEC.text, passwordTEC.text);
      addUserOnFireStore(userCredential);
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

  void addUserOnFireStore(UserCredential userCredential) async {
    User user = userCredential.user!;

    UserModel userModel = UserModel(
      id: user.uid ?? "",
      displayName: user.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
      active: true,
      accessToken: userCredential.credential?.accessToken ?? "",
    );

    await userRepository.addNewUser(userModel);

    isLoading = false;
    Fluttertoast.showToast(
      msg: "Login Success",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    Get.offAllNamed(Routes.HOME);
  }

  void onTapHidePassword() {
    _isHidePassword.toggle();
  }
}
