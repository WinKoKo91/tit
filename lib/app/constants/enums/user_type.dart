
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

