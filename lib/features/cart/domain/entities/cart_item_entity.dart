import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;
  final int selectedColorValue;
  final String selectedSize;

  const CartItemEntity({
    required this.product,
    required this.quantity,
    required this.selectedColorValue,
    required this.selectedSize,
  });

  String get id => '${product.id}::$selectedSize::$selectedColorValue';

  CartItemEntity copyWith({int? quantity}) => CartItemEntity(
    product: product,
    quantity: quantity ?? this.quantity,
    selectedColorValue: selectedColorValue,
    selectedSize: selectedSize,
  );
}
