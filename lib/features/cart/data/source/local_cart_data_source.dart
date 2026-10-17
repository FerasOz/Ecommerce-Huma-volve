import 'package:ecommerce_app_huma_volve/features/cart/data/models/cart_item_model.dart';

abstract class LocalCartDataSource {
  Future<List<CartItemModel>> getCartItems();

  Future<void> saveCartItem(CartItemModel item);

  Future<void> deleteCartItem(String itemId);
}
