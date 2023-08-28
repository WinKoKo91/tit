import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> addNewUser(UserModel userModel);

  Future<UserModel?> getUser();

  Future<void> signOut();
}
