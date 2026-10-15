import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final int _productsLimit = 10;
  int _productsOffset = 0;
  int _productsRequestVersion = 0;
  int? _selectedCategoryId;
  bool isLoadingMoreProducts = false;
  bool hasMoreProducts = true;
  bool _hasLoadedInitialProducts = false;
  final List<ProductEntity> _products = [];

  HomeCubit(this.getCategoriesUseCase, this.getProductsUseCase)
    : super(HomeInitialState());

  void getCategories() async {
    emit(CategoryLoadingState());
    final categories = await getCategoriesUseCase.invoke();
    if (isClosed) return;
    categories.fold(
      (failure) => emit(CategoryErrorState(failure.message)),
      (categories) => emit(CategorySuccessState(categories)),
    );
  }

  Future<void> getProducts(int? categoryId) async {
    final requestVersion = ++_productsRequestVersion;
    _selectedCategoryId = categoryId;
    _products
      ..clear();
    _productsOffset = 0;
    isLoadingMoreProducts = false;
    hasMoreProducts = true;
    _hasLoadedInitialProducts = false;

    emit(ProductLoadingState());
    final products = await getProductsUseCase.invoke(
      categoryId,
      offset: 0,
      limit: _productsLimit,
    );

    if (isClosed || requestVersion != _productsRequestVersion) return;

    products.fold(
      (failure) => emit(ProductErrorState(failure.message)),
      (products) {
        _products.addAll(products);
        _productsOffset = products.length;
        hasMoreProducts = products.length == _productsLimit;
        _hasLoadedInitialProducts = true;
        emit(ProductSuccessState(List.unmodifiable(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMoreProducts ||
        !hasMoreProducts ||
        !_hasLoadedInitialProducts) {
      return;
    }

    isLoadingMoreProducts = true;
    final requestVersion = _productsRequestVersion;
    emit(ProductsLoadingMore());

    final products = await getProductsUseCase.invoke(
      _selectedCategoryId,
      offset: _productsOffset,
      limit: _productsLimit,
    );

    if (isClosed || requestVersion != _productsRequestVersion) return;

    products.fold(
      (failure) {
        isLoadingMoreProducts = false;
        emit(ProductsLoadingError(failure.message));
      },
      (newProducts) {
        _products.addAll(newProducts);
        _productsOffset += newProducts.length;
        hasMoreProducts = newProducts.length == _productsLimit;
        isLoadingMoreProducts = false;
        emit(ProductSuccessState(List.unmodifiable(_products)));
      },
    );
  }
}
