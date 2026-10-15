import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase(this.homeRepository);
  Future<Either<Failure, List<ProductEntity>>> invoke(
    int? categoryId, {
    required int offset,
    required int limit,
  }) => homeRepository.getProducts(categoryId, offset: offset, limit: limit);
}
