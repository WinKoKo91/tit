import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/person_model.dart';

import '../entities/chat_entity.dart';
import '../entities/person_entity.dart';
import '../entities/room_entity.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel extends RoomEntity {
  RoomModel({
    required String id,
    required String message,
    required int timestamp,
    UserType? userType,
    MessageStatus? messageStatus,
    required PersonModel personModel,
  }) : super(
            message: message,
            id: id,
            timestamp: timestamp,
            userType: userType ?? UserType.sender,
            messageStatus: messageStatus ?? MessageStatus.delivering,
            personModel: personModel);

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  factory RoomModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? json = snapshot.data();
    return RoomModel.fromJson(json!);
  }

  Map<String, dynamic> toFireStore() => _$RoomModelToJson(this);
}
