// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      id: json['id'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as int,
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
      messageStatus:
          $enumDecodeNullable(_$MessageStatusEnumMap, json['messageStatus']),
      personModel:
          PersonModel.fromJson(json['personModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'messageStatus': _$MessageStatusEnumMap[instance.messageStatus]!,
      'personModel': instance.personModel,
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
