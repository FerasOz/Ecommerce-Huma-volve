import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_entity.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginResponseEntity loginResponse;

  LoginSuccessState({required this.loginResponse});
}

class LoginErrorState extends LoginStates {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}
