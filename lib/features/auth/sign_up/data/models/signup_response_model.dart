import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';

class SignupResponseModel extends SignupResponseEntity {
  SignupResponseModel({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required super.avatar,
    required super.createdAt,
    required super.updatedAt,
  });

  SignupResponseModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        avatar: json['avatar'],
        createdAt:
            json['creationAt'] ?? json['createdAt'] ?? json['created_at'] ?? '',
        updatedAt: json['updatedAt'] ?? json['updated_at'] ?? '',
      );
}
