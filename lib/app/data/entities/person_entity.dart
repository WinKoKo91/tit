class PersonEntity {
  String? displayName;
  String? photoUrl;
  String? id;
  bool active;
  bool isFriend;

  PersonEntity({this.displayName, this.photoUrl, this.id, this.active = false, this.isFriend = false});
}
