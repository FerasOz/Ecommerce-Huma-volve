import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/cubit/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    final loginResponse = await loginUseCase.invoke(email, password);
    loginResponse.fold(
      (failure) => emit(LoginErrorState(errorMessage: failure.message)),
      (loginResponse) => emit(LoginSuccessState(loginResponse: loginResponse)),
    );
  }
}
