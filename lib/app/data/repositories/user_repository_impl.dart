import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/data/repositories/user_repository.dart';

import '../../core/services/auth/auth_service.dart';
import '../../core/services/network_connection_service.dart';
import '../remote/firestore_user.dart';

class UserRepositoryImpl extends UserRepository {
  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());
  final NetworkConnectionService _networkConnectionService =
      Get.find<NetworkConnectionService>();

  @override
  Future<void> addNewUser(UserModel userModel) async {
    await _preferenceManager.setString(
        AppKey.user, json.encode(userModel.toJson()));

    await _preferenceManager.setString(AppKey.id, userModel.id!);
    if (userModel.active == null) {}
    return await FireStoreUser.addUser(userModel);
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      if (await _networkConnectionService.isOnline()) {
        String id = FirebaseAuth.instance.currentUser?.uid ?? "";
        if (id.isEmpty) {
          signOut();
        }
        return FireStoreUser.getUser(id);
      } else {
        String result =
            await _preferenceManager.getString(AppKey.user, defaultValue: "");
        if (result.isEmpty) {
          signOut();
        }
        var resultJson = json.decode(result);
        return UserModel.fromJson(resultJson);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    String result =
        await _preferenceManager.getString(AppKey.user, defaultValue: "");
    try {
      var resultJson = json.decode(result);
      await FireStoreUser.signOut(resultJson[AppKey.id]);
    } catch (e) {
      print(e);
    } finally {
      bool isFirstTimeOpen = await _preferenceManager
          .getBool(AppKey.firstTimeOpen, defaultValue: false);
      _preferenceManager.clear();
      _preferenceManager.setBool(AppKey.firstTimeOpen, isFirstTimeOpen);
    }
  }

  @override
  Future<UserModel?> editUserInfo(UserModel userModel) async {
    try {
      UserModel? result = await FireStoreUser.editUser(userModel);
      await _preferenceManager.setString(
          AppKey.user, json.encode(result!.toJson()));
      return result;
    } catch (e) {
      print(e);
    }
  }
}
