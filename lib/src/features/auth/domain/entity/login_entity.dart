class LoginEntity {
  const LoginEntity({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
