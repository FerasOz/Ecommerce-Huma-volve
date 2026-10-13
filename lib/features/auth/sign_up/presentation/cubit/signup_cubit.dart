import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/use_cases/signup_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/presentation/cubit/signup_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupStates> {
  final SignupUseCase signupUseCase;

  SignupCubit({required this.signupUseCase}) : super(SignupInitialState());

  Future<void> signup(String name, String email, String password) async {
    emit(SignupLoadingState());
    final signupResponse = await signupUseCase.invoke(name, email, password);
    signupResponse.fold(
      (failure) => emit(SignupErrorState(errorMessage: failure.message)),
      (response) => emit(SignupSuccessState(signupResponse: response)),
    );
  }
}
