import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({required super.accessToken, required super.refreshToken});

  LoginResponseModel.fromJson(Map<String, dynamic> json)
    : super(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
      );
}
