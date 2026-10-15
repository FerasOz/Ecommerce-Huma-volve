class SignupResponseEntity {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String avatar;
  final String createdAt;
  final String updatedAt;

  SignupResponseEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });
}
