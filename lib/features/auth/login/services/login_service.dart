import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_response_model.dart';

class LoginService {
  DioHelper dioHelper;

  LoginService(this.dioHelper);
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioHelper.dio.post(
      ApiConstants.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
