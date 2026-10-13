import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_response_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/source/remote_login_data_source.dart';

class RemoteLoginDataSourceImpl implements RemoteLoginDataSource {
  final DioHelper dioHelper;
  RemoteLoginDataSourceImpl({required this.dioHelper});

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    final response = await dioHelper.dio.post(
      ApiConstants.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final data = LoginResponseModel.fromJson(response.data);
    await SecureStorage.saveAccessToken(data.accessToken);
    await SecureStorage.saveRefreshToken(data.refreshToken);
    return data;
  }
}
