// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as int,
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
      messageStatus:
          $enumDecodeNullable(_$MessageStatusEnumMap, json['messageStatus']),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'message': instance.message,
      'id': instance.id,
      'timestamp': instance.timestamp,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'messageStatus': _$MessageStatusEnumMap[instance.messageStatus]!,
    };

const _$UserTypeEnumMap = {
  UserType.sender: 'sender',
  UserType.receiver: 'receiver',
};

const _$MessageStatusEnumMap = {
  MessageStatus.delivering: 'delivering',
  MessageStatus.send: 'send',
  MessageStatus.seen: 'seen',
  MessageStatus.fail: 'fail',
};
