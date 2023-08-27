import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/user_model.dart';

class FireStoreUser {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection(AppKey.users);

  static Future<void> addUser(UserModel userModel) async {
    final db = FirebaseFirestore.instance;
    var userdata = await _fireStoreUserCollection
        .withConverter(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel userModel, options) =>
              userModel.toFireStore(),
        )
        .where(AppKey.id, isEqualTo: userModel.id)
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
  }
}
