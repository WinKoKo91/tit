import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth_service.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../data/remote/firestore_user_repo.dart';

class LoginController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final db = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

  final _isLogin = false.obs;

  bool get isLogin => _isLogin.value;

  set isLogin(value) {
    _isLogin.value = value;
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
    super.onClose();
  }

  void onGoogleLogin() async {
    try {
      UserCredential userCredential = await authService.signInWithGoogle();
      //Get.toNamed(Routes.HOME, arguments: userCredential.user);

      isLogin = true;
      User user = userCredential.user!;

      UserModel userModel = UserModel(
          id: user.uid,
          displayName: user.displayName!,
          email: user.email!,
          photoUrl: user.photoURL!,
          accessToken: userCredential.credential!.accessToken!);

      var userdata = await db
          .collection(AppKey.users)
          .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFireStore(),
          )
          .where(AppKey.id, isEqualTo: user.uid)
          .get();

      if (userdata.docs.isEmpty) {
        await db
            .collection(AppKey.users)
            .withConverter(
              fromFirestore: UserModel.fromFireStore,
              toFirestore: (UserModel userModel, options) =>
                  userModel.toFireStore(),
            )
            .add(userModel);
      }
      isLogin = false;
      Get.offAllNamed(Routes.HOME, arguments: userModel);
    } catch (e) {
      print(e.toString());
    }
  }

  void onAppleLogin() async {
    try {
      UserCredential userCredential = await authService.signInWithApple();
      print(userCredential.toString());
      Get.toNamed(Routes.HOME, arguments: userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  void onFacebookLogin() async {
    try {
      UserCredential userCredential = await authService.signInWithFacebook();
      Get.toNamed(Routes.HOME, arguments: userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }
}
