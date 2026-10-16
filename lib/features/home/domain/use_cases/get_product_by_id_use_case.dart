import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/helpers/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetProductByIdUseCase {
  final HomeRepository homeRepository;

  GetProductByIdUseCase(this.homeRepository);

  Future<Either<Failure, ProductEntity>> invoke(int productId) =>
      homeRepository.getProductById(productId);
}
