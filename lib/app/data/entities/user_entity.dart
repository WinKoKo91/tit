class UserEntity {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;
  String? id;
  bool active;

  UserEntity(
      {this.accessToken,
      this.displayName,
      this.email,
      this.photoUrl,
      this.id,
      this.active = false});
}
