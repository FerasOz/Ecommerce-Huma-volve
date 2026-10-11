import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_request_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_response_model.dart';

class SignupService {
  DioHelper dioHelper;

  SignupService(this.dioHelper);
  Future<SignupResponseModel> signup(SignupRequestModel request) async {
    final response = await dioHelper.dio.post(
      ApiConstants.signupEndpoint,
      data: {
        'name': request.name,
        'email': request.email,
        'password': request.password,
        'avatar':
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      },
    );
    return SignupResponseModel.fromJson(response.data);
  }
}
