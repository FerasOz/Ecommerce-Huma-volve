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
  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await _dioHelper.dio.get(
      "${ApiConstants.categoriesEndpoint}/$categoryId/${ApiConstants.productsEndpoint}",
    );
    return (response.data as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();
  }
}
