import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.name});

  CategoryModel.fromJson(Map<String, dynamic> json) : super(id: json['id'], name: json['name']);
}
