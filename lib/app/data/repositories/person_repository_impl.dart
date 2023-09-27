import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/models/person_model.dart';
import 'package:tit/app/data/models/room_model.dart';
import 'package:tit/app/data/models/user_model.dart';
import 'package:tit/app/data/remote/firestore_chat.dart';
import 'package:tit/app/data/remote/firestore_person.dart';
import 'package:tit/app/data/remote/firestore_user.dart';

import '../../core/services/network_connection_service.dart';
import '../local/preference/preference_manager.dart';
import 'person_repository.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());

  final NetworkConnectionService _connectionService =
      Get.find<NetworkConnectionService>();

  @override
  Future<void> addPerson(String id, PersonModel personModel) async {
    if (await _connectionService.isOnline()) {
      await FireStorePerson.addPerson(id, personModel);

      int timestamp = DateTime.now().millisecondsSinceEpoch * 1000; //Today Date

      RoomModel roomModel = RoomModel(
          id: '', message: '', timestamp: timestamp, personModel: personModel);
      await FireStoreChat.createRoom(id, roomModel);
    }
  }

  @override
  Future<Stream<QuerySnapshot>> getPersons() async {
    String id = await _preferenceManager.getString(AppKey.id);
    return FireStorePerson.getPersons(id);
  }

  @override
  Future<PersonModel?> checkPerson(String id) async {
    if (await _connectionService.isOnline()) {
      final userModel = await FireStoreUser.getUser(id);
      if (userModel != null) {
        return PersonModel(
          displayName: userModel!.displayName!,
          photoUrl: userModel!.photoUrl!,
          id: userModel!.id!,
        );
      }
    } else {
      String result = await _preferenceManager.getString(AppKey.user);

      var resultJson = json.decode(result);
      final userModel = UserModel.fromJson(resultJson);
      return PersonModel(
        displayName: userModel.displayName!,
        photoUrl: userModel.photoUrl!,
        id: userModel.id!,
      );
    }
  }
}
