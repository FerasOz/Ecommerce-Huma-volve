import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCartItems();

  Future<Either<Failure, Unit>> addCartItem(CartItemEntity item);

  Future<Either<Failure, Unit>> updateQuantity(String itemId, int quantity);

  Future<Either<Failure, Unit>> removeCartItem(String itemId);
}
