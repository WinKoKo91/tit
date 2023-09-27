class ChatEntity {
  String message;
  String id;
  int timestamp;
  UserType userType;
  MessageStatus messageStatus;

  ChatEntity({
    required this.message,
    required this.timestamp,
    required this.id,
    this.userType = UserType.sender,
    this.messageStatus = MessageStatus.delivering,
  });
}

enum UserType {
  sender(1, 'sender'),
  receiver(2, 'receiver');

  final int number;
  final String value;

  const UserType(this.number, this.value);

  static UserType getType(int number) =>
      UserType.values.firstWhere((activity) => activity.number == number);

  static UserType getTypeByTitle(String title) =>
      UserType.values.firstWhere((activity) => activity.name == title);

  static String getValue(int number) =>
      UserType.values.firstWhere((activity) => activity.number == number).value;
}

enum MessageStatus {
  delivering(1, 'delivering'),
  send(2, 'send'),
  seen(3, 'seen'),
  fail(4, 'fail');

  final int number;
  final String value;

  const MessageStatus(this.number, this.value);

  static MessageStatus getType(int number) =>
      MessageStatus.values.firstWhere((activity) => activity.number == number);

  static MessageStatus getTypeByTitle(String title) =>
      MessageStatus.values.firstWhere((activity) => activity.name == title);

  static String getValue(int number) => MessageStatus.values
      .firstWhere((activity) => activity.number == number)
      .value;
}
