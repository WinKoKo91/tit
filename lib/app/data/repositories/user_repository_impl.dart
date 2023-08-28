import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/data/repositories/user_repository.dart';

import '../../core/services/auth/auth_service.dart';
import '../remote/firestore_user.dart';

class UserRepositoryImpl extends UserRepository {
  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());

  @override
  Future<void> addNewUser(UserModel userModel) async {
    await _preferenceManager.setString(
        AppKey.user, json.encode(userModel.toJson()));
    return await FireStoreUser.addUser(userModel);
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      String result =
          await _preferenceManager.getString(AppKey.user, defaultValue: "");
      var resultJson = json.decode(result);
      return UserModel.fromJson(resultJson);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      String result =
          await _preferenceManager.getString(AppKey.user, defaultValue: "");
      bool isFirstTimeOpen = await _preferenceManager
          .getBool(AppKey.firstTimeOpen, defaultValue: false);

      var resultJson = json.decode(result);
      await FireStoreUser.signOut(resultJson[AppKey.id]);
      _preferenceManager.clear();
      _preferenceManager.setBool(AppKey.firstTimeOpen, isFirstTimeOpen);
    } catch (e) {
      print(e);
    }
  }
}
