import 'package:tit/app/data/models/person_model.dart';

import 'chat_entity.dart';
import 'person_entity.dart';

class RoomEntity {
  final String? id;
  final String message;
  final int timestamp;
  final UserType userType;
  final MessageStatus messageStatus;
  final PersonModel personModel;

  RoomEntity({
    required this.message,
    required this.timestamp,
     this.id,
    required this.personModel,
    this.userType = UserType.sender,
    this.messageStatus = MessageStatus.delivering,
  });
}
