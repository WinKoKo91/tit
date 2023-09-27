import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth/auth_service.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/person_model.dart';
import 'package:tit/app/data/models/room_model.dart';
import 'package:tit/app/data/models/user_model.dart';

class FireStoreChat {
  static final _fireStoreChatCollection =
      FirebaseFirestore.instance.collection(AppKey.chatCollection);

  static Future<void> createRoom(String id, RoomModel roomModel) async {
    try {
      var roomData = await _fireStoreChatCollection
          .doc(id)
          .collection(AppKey.roomCollection)
          .doc(roomModel.id)
          .withConverter(
            fromFirestore: RoomModel.fromFireStore,
            toFirestore: (RoomModel roomModel, options) =>
                roomModel.toFireStore(),
          )
          .get();

      if (!roomData.exists) {
        await _fireStoreChatCollection
            .doc(id)
            .collection(AppKey.roomCollection)
            .doc(roomModel.id)
            .withConverter(
              fromFirestore: RoomModel.fromFireStore,
              toFirestore: (RoomModel roomModel, options) =>
                  roomModel.toFireStore(),
            )
            .set(roomModel);
      } else {
        // await personData.reference.update({'active': true});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<RoomModel>?> getRooms(String userId) async {
    var roomData = await _fireStoreChatCollection
        .withConverter(
          fromFirestore: PersonModel.fromFireStore,
          toFirestore: (PersonModel personModel, options) =>
              personModel.toFireStore(),
        )
        .doc(userId)
        .collection(AppKey.roomCollection)
        .doc()
        .get();

    return null;
  }
}
