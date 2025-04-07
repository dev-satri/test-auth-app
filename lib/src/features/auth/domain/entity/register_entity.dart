class RegisterEntity {
  const RegisterEntity({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "password": password};
  }
}
