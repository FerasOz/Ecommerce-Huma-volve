import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/source/remote_home_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final RemoteHomeDataSource remoteHomeDataSource;

  HomeRepositoryImpl(this.remoteHomeDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteHomeDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int productId) async {
    try {
      final product = await remoteHomeDataSource.getProductById(productId);
      return Right(product);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    int? categoryId, {
    required int offset,
    required int limit,
  }) async {
    try {
      final products = await remoteHomeDataSource.getProducts(
        categoryId,
        offset: offset,
        limit: limit,
      );
      return Right(products);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
