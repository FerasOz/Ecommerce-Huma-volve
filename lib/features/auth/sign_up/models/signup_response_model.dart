class SignupResponseModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? avatar;
  String? createdAt;
  String? updatedAt;

  SignupResponseModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
