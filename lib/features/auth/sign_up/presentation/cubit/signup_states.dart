import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';

abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupSuccessState extends SignupStates {
  final SignupResponseEntity signupResponse;

  SignupSuccessState({required this.signupResponse});
}

class SignupErrorState extends SignupStates {
  final String errorMessage;

  SignupErrorState({required this.errorMessage});
}
