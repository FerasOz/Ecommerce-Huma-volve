import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_response_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/source/remote_signup_data_source.dart';

class RemoteSignupDataSourceImpl implements RemoteSignupDataSource {
  final DioHelper dioHelper;
  RemoteSignupDataSourceImpl({required this.dioHelper});

  @override
  Future<SignupResponseModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dioHelper.dio.post(
      ApiConstants.signupEndpoint,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'avatar': "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      },
    );
    return SignupResponseModel.fromJson(response.data);
  }
}
