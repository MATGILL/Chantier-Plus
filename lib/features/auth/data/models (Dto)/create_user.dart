class CreateUser {
  String email;
  String fullName;
  String password;
  String role;

  CreateUser(
      {required this.password,
      required this.email,
      required this.fullName,
      required this.role});
}
