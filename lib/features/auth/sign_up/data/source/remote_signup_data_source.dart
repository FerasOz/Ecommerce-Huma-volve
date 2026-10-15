import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_response_model.dart';

abstract class RemoteSignupDataSource {
  Future<SignupResponseModel> signup({
    required String name,
    required String email,
    required String password,
  });
}
