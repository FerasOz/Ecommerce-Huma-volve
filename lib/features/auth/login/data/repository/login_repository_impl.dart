import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/source/remote_login_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final RemoteLoginDataSource remoteLoginDataSource;
  LoginRepositoryImpl(this.remoteLoginDataSource);

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final loginResponse = await remoteLoginDataSource.login(email, password);
      return Right(loginResponse);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
