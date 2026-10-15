import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class CategoryLoadingState extends HomeStates {}

class CategorySuccessState extends HomeStates {
  final List<CategoryEntity> categories;

  CategorySuccessState(this.categories);
}

class CategoryErrorState extends HomeStates {
  final String error;

  CategoryErrorState(this.error);
}

class ProductLoadingState extends HomeStates {}

class ProductSuccessState extends HomeStates {
  final List<ProductEntity> products;

  ProductSuccessState(this.products);
}

class ProductErrorState extends HomeStates {
  final String error;

  ProductErrorState(this.error);
}

class ProductsLoadingMore extends HomeStates {}

class ProductsLoadingError extends HomeStates {
  final String error;

  ProductsLoadingError(this.error);
}
