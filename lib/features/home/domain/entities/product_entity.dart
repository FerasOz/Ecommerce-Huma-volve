import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final String slug;
  final String description;
  final int price;
  final CategoryEntity category;
  final List<String> images;

  ProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
  });
}
