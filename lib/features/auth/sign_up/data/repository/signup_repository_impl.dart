import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/source/remote_signup_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repository/signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository {
  final RemoteSignupDataSource remoteSignupDataSource;
  SignupRepositoryImpl(this.remoteSignupDataSource);

  @override
  Future<Either<Failure, SignupResponseEntity>> signup(
    SignupRequestEntity signupRequestEntity,
  ) async {
    try {
      final signupResponse = await remoteSignupDataSource.signup(
        name: signupRequestEntity.name,
        email: signupRequestEntity.email,
        password: signupRequestEntity.password,
      );
      return Right(signupResponse);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
