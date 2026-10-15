import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponseEntity>> login(
    String email,
    String password,
  );
}
