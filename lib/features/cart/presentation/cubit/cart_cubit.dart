import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/add_cart_item_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/remove_cart_item_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/update_cart_item_quantity_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/presentation/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddCartItemUseCase addCartItemUseCase;
  final UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;

  List<CartItemEntity> _items = const [];
  Future<void> _pendingAction = Future<void>.value();

  CartCubit({
    required this.getCartItemsUseCase,
    required this.addCartItemUseCase,
    required this.updateCartItemQuantityUseCase,
    required this.removeCartItemUseCase,
  }) : super(CartInitialState());

  Future<void> loadCart() async {
    emit(CartLoadingState());
    final result = await getCartItemsUseCase.invoke();
    if (isClosed) return;

    result.fold(
      (failure) => emit(CartErrorState(failure.message, items: _items)),
      (items) {
        _items = items;
        emit(CartLoadedState(_items));
      },
    );
  }

  Future<void> addItem(CartItemEntity item) =>
      _enqueueAction(() => addCartItemUseCase.invoke(item));

  Future<void> updateQuantity(String itemId, int quantity) => _enqueueAction(
    () => updateCartItemQuantityUseCase.invoke(itemId, quantity),
  );

  Future<void> removeItem(String itemId) =>
      _enqueueAction(() => removeCartItemUseCase.invoke(itemId));

  Future<void> _enqueueAction(Future<Either<Failure, Unit>> Function() action) {
    final nextAction = _pendingAction.then((_) => _runAction(action));
    _pendingAction = nextAction;
    return nextAction;
  }

  Future<void> _runAction(
    Future<Either<Failure, Unit>> Function() action,
  ) async {
    try {
      final result = await action();
      if (isClosed) return;

      await result.fold<Future<void>>(
        (failure) async {
          emit(CartErrorState(failure.message, items: _items));
        },
        (_) async {
          final refreshedCart = await getCartItemsUseCase.invoke();
          if (isClosed) return;
          refreshedCart.fold(
            (failure) => emit(CartErrorState(failure.message, items: _items)),
            (items) {
              _items = items;
              emit(CartLoadedState(_items));
            },
          );
        },
      );
    } catch (error) {
      if (!isClosed) {
        emit(CartErrorState(error.toString(), items: _items));
      }
    }
  }
}
