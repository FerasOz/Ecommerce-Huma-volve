import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupResponseEntity>> signup(
    SignupRequestEntity signupRequestEntity,
  );
}
