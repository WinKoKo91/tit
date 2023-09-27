import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tit/app/data/entities/user_entity.dart';
import 'package:tit/app/data/models/person_model.dart';

import '../entities/chat_entity.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends ChatEntity {
  ChatModel({
    required String id,
    required String message,
    required int timestamp,
    UserType? userType,
    MessageStatus? messageStatus,
  }) : super(
            message: message,
            id: id,
            timestamp: timestamp,
            userType: userType ?? UserType.sender,
            messageStatus: messageStatus ?? MessageStatus.delivering);

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  factory ChatModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Map<String, dynamic>? json = snapshot.data();
    return ChatModel.fromJson(json!);
  }

  Map<String, dynamic> toFireStore() => _$ChatModelToJson(this);
}
