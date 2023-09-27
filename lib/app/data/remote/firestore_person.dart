import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth/auth_service.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/person_model.dart';
import 'package:tit/app/data/models/user_model.dart';

class FireStorePerson {
  static final _fireStoreFriendCollection =
      FirebaseFirestore.instance.collection(AppKey.contactCollection);

  static final _authService = Get.find<AuthService>();

  static Future<void> addPerson(String id, PersonModel personModel) async {
    try {
      var personData = await _fireStoreFriendCollection
          .doc(id)
          .collection(AppKey.personCollection)
          .doc(personModel.id)
          .withConverter(
            fromFirestore: PersonModel.fromFireStore,
            toFirestore: (PersonModel personModel, options) =>
                personModel.toFireStore(),
          )
          .get();

      if (!personData.exists) {
        await _fireStoreFriendCollection
            .doc(id)
            .collection(AppKey.personCollection)
            .doc(personModel.id)
            .withConverter(
              fromFirestore: PersonModel.fromFireStore,
              toFirestore: (PersonModel personModel, options) =>
                  personModel.toFireStore(),
            )
            .set(personModel);
      } else {
        // await personData.reference.update({'active': true});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Stream<QuerySnapshot> getPersons(String userId) {
    return _fireStoreFriendCollection
        .doc(userId)
        .collection(AppKey.personCollection)
        .withConverter(
          fromFirestore: PersonModel.fromFireStore,
          toFirestore: (PersonModel personModel, options) =>
              personModel.toFireStore(),
        )
        .snapshots();
  }
}
