import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartLoadedState extends CartStates {
  final List<CartItemEntity> items;

  CartLoadedState(this.items);
}

class CartErrorState extends CartStates {
  final String message;
  final List<CartItemEntity> items;

  CartErrorState(this.message, {this.items = const []});
}
