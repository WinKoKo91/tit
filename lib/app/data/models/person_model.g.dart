// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String,
      id: json['id'] as String,
      active: json['active'] as bool? ?? false,
      isFriend: json['isFriend'] as bool? ?? false,
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'id': instance.id,
      'active': instance.active,
      'isFriend': instance.isFriend,
    };
