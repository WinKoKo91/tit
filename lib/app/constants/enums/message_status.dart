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
