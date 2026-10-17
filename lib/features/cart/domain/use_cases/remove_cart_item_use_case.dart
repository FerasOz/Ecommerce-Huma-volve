import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';

class RemoveCartItemUseCase {
  final CartRepository cartRepository;

  RemoveCartItemUseCase(this.cartRepository);

  Future<Either<Failure, Unit>> invoke(String itemId) =>
      cartRepository.removeCartItem(itemId);
}
