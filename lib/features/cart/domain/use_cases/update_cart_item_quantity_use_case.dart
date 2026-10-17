import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';

class UpdateCartItemQuantityUseCase {
  final CartRepository cartRepository;

  UpdateCartItemQuantityUseCase(this.cartRepository);

  Future<Either<Failure, Unit>> invoke(String itemId, int quantity) =>
      cartRepository.updateQuantity(itemId, quantity);
}
