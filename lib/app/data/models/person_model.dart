import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tit/app/data/entities/user_entity.dart';

import '../entities/person_entity.dart';

part 'person_model.g.dart';

@JsonSerializable()
class PersonModel extends PersonEntity {
  PersonModel({
    required String displayName,
    required String photoUrl,
    required String id,
    bool? active = false,
    bool? isFriend = false,
  }) : super(
            displayName: displayName,
            id: id,
            photoUrl: photoUrl,
            active: active ?? false,
            isFriend: isFriend ?? false);

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);

  factory PersonModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? json = snapshot.data();
    return PersonModel.fromJson(json!);
  }

  factory PersonModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String displayName = documentSnapshot.get('displayName');
    String photoUrl = documentSnapshot.get('photoUrl');
    String id = documentSnapshot.get('id');
    bool active = documentSnapshot.get('active');
    bool isFriend = documentSnapshot.get('isFriend');

    return PersonModel(
        displayName: displayName,
        photoUrl: photoUrl,
        id: id,
        active: active,
        isFriend: isFriend);
  }

  Map<String, dynamic> toFireStore() => _$PersonModelToJson(this);



  static PersonModel convertEntityToPersonModel(UserEntity userEntity) {
    return PersonModel(
      displayName: userEntity.displayName ?? "",
      photoUrl: userEntity.photoUrl ?? "",
      id: userEntity.id ?? "",
    );
  }

  toEntity() {
    return PersonEntity(
      displayName: displayName,
      photoUrl: photoUrl,
      id: id,
      active: active,
      isFriend: isFriend,
    );
  }
}
