import 'package:ecommerce_app_huma_volve/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/source/local_cart_data_source.dart';
import 'package:hive/hive.dart';

class LocalCartDataSourceImpl implements LocalCartDataSource {
  static const String boxName = 'cart_items';

  final Box<String> _box;

  LocalCartDataSourceImpl(this._box);

  @override
  Future<List<CartItemModel>> getCartItems() async =>
      _box.values.map(CartItemModel.fromStorage).toList(growable: false);

  @override
  Future<void> saveCartItem(CartItemModel item) =>
      _box.put(item.id, item.toStorage());

  @override
  Future<void> deleteCartItem(String itemId) => _box.delete(itemId);
}
