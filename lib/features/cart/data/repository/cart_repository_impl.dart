import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/source/local_cart_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final LocalCartDataSource localCartDataSource;

  CartRepositoryImpl(this.localCartDataSource);

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems() =>
      _guard(() async {
        final items = await localCartDataSource.getCartItems();
        return List<CartItemEntity>.unmodifiable(items);
      });

  @override
  Future<Either<Failure, Unit>> addCartItem(CartItemEntity item) =>
      _guard(() async {
        final items = await localCartDataSource.getCartItems();
        CartItemModel? existingItem;

        for (final currentItem in items) {
          if (currentItem.id == item.id) {
            existingItem = currentItem;
            break;
          }
        }

        final itemToSave = existingItem == null
            ? CartItemModel.fromEntity(item)
            : CartItemModel.fromEntity(
                item.copyWith(quantity: existingItem.quantity + item.quantity),
              );

        await localCartDataSource.saveCartItem(itemToSave);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> updateQuantity(String itemId, int quantity) =>
      _guard(() async {
        final items = await localCartDataSource.getCartItems();
        for (final item in items) {
          if (item.id == itemId) {
            if (quantity <= 0) {
              await localCartDataSource.deleteCartItem(itemId);
            } else {
              await localCartDataSource.saveCartItem(
                CartItemModel.fromEntity(item.copyWith(quantity: quantity)),
              );
            }
            break;
          }
        }
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> removeCartItem(String itemId) =>
      _guard(() async {
        await localCartDataSource.deleteCartItem(itemId);
        return unit;
      });

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } catch (error) {
      return Left(ErrorHandler.handleError(error));
    }
  }
}
