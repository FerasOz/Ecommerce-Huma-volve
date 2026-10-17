import 'dart:convert';

import 'package:ecommerce_app_huma_volve/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.product,
    required super.quantity,
    required super.selectedColorValue,
    required super.selectedSize,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) => CartItemModel(
    product: entity.product,
    quantity: entity.quantity,
    selectedColorValue: entity.selectedColorValue,
    selectedSize: entity.selectedSize,
  );

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    quantity: json['quantity'] as int,
    selectedColorValue: json['selectedColorValue'] as int,
    selectedSize: json['selectedSize'] as String,
  );

  factory CartItemModel.fromStorage(String value) =>
      CartItemModel.fromJson(jsonDecode(value) as Map<String, dynamic>);

  String toStorage() => jsonEncode({
    'product': {
      'id': product.id,
      'title': product.title,
      'slug': product.slug,
      'description': product.description,
      'price': product.price,
      'category': {'id': product.category.id, 'name': product.category.name},
      'images': product.images,
    },
    'quantity': quantity,
    'selectedColorValue': selectedColorValue,
    'selectedSize': selectedSize,
  });
}
