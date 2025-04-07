class ProfileModel {
  const ProfileModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.token});
  final String id;
  final String name;
  final String email;
  final String token;

  static ProfileModel fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        token: json["token"]);
  }
}
