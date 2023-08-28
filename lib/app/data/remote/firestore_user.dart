import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth/auth_service.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/user_model.dart';

class FireStoreUser {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection(AppKey.users);

  static final _authService = Get.find<AuthService>();

  static Future<void> addUser(UserModel userModel) async {
    var userdata = await _fireStoreUserCollection
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFireStore(),
        )
        .where(AppKey.id, isEqualTo: userModel.id)
        .get();

    if (userdata.docs.isEmpty) {
      await _fireStoreUserCollection
          .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFireStore(),
          )
          .add(userModel);
    } else {
      await userdata.docs[0].reference.update({'active': true});
    }
  }

  static signOut(String id) async {
    var userdata = await _fireStoreUserCollection
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFireStore(),
        )
        .where(AppKey.id, isEqualTo: id)
        .get();

    await userdata.docs[0].reference.update({'active': false});
    _authService.signOut();
  }
}
