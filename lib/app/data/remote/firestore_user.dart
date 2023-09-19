import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    try {
      var userdata = await _fireStoreUserCollection
          .doc(userModel.id)
          .withConverter(
            fromFirestore: UserModel.fromFireStore,
            toFirestore: (UserModel userModel, options) =>
                userModel.toFireStore(),
          )
          .get();

      if (!userdata.exists) {
        await _fireStoreUserCollection
            .withConverter(
              fromFirestore: UserModel.fromFireStore,
              toFirestore: (UserModel userModel, options) =>
                  userModel.toFireStore(),
            )
            .doc(userModel.id)
            .set(userModel);
      } else {
        await userdata.reference.update({'active': true});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static signOut(String id) async {
    var userdata = await _fireStoreUserCollection
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFireStore(),
        )
        .doc(id)
        .get();

    await userdata.reference.update({'active': false});
    _authService.logout();
  }

  static Future<UserModel?> getUser(String userId) async {
    var userData = await _fireStoreUserCollection
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFireStore(),
        )
        .doc(userId)
        .get();

    if (userData.exists) {
      UserModel userModel = userData.data()!;
      return userModel;
    } else {
      return null;
    }
  }

  static Future<UserModel?> editUser(UserModel userModel) async {
    await _fireStoreUserCollection
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFireStore(),
        )
        .doc(userModel.id)
        .update(userModel.toFireStore())
        .onError((error, stackTrace) => print(error))
        .then((value) => (print("success")));
    return getUser(userModel.id ?? "");
  }
}
