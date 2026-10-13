import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_request_entity.dart';

class SignupRequestModel extends SignupRequestEntity {
  SignupRequestModel({
    required super.name,
    required super.email,
    required super.password,
  });
}
