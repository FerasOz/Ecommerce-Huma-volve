import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.price,
    required super.description,
    required super.category,
    required super.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'],
        title: json['title'],
        slug: json['slug'],
        price: json['price'],
        description: json['description'],
        category: CategoryModel.fromJson(json['category']),
        images: List<String>.from(json['images'] ?? []),
      );
}
