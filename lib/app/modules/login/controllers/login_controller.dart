import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/services/auth_service.dart';
import 'package:tit/app/routes/app_pages.dart';

class LoginController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final db = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();

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
      Get.toNamed(Routes.HOME, arguments: userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  void onAppleLogin() async {
    try {
      UserCredential userCredential = await authService.signInWithApple();
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
