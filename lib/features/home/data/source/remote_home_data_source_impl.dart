import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/source/remote_home_data_source.dart';

class RemoteHomeDataSourceImpl implements RemoteHomeDataSource {
  final DioHelper _dioHelper;
  RemoteHomeDataSourceImpl(this._dioHelper);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dioHelper.dio.get(ApiConstants.categoriesEndpoint);
    return (response.data as List)
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  @override
  Future<ProductModel> getProductById(int productId) async {
    final response = await _dioHelper.dio.get(
      '${ApiConstants.productsEndpoint}/$productId',
    );
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<List<ProductModel>> getProducts(
    int? categoryId, {
    required int offset,
    required int limit,
  }) async {
    final endpoint = categoryId == null
        ? ApiConstants.productsEndpoint
        : '${ApiConstants.categoriesEndpoint}/$categoryId/${ApiConstants.productsEndpoint}';
    final response = await _dioHelper.dio.get(
      endpoint,
      queryParameters: {'offset': offset, 'limit': limit},
    );
    return (response.data as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();
  }
}
