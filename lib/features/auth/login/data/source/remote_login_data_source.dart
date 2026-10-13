import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_response_model.dart';

abstract class RemoteLoginDataSource {
  Future<LoginResponseModel> login(String email, String password);
}
