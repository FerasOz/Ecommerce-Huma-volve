import 'package:ecommerce_app_huma_volve/features/home/cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInitialState());

  void getCategories() async {
    emit(CategoryLoadingState());
    try {
      final categories = await homeService.getCategories();
      emit(CategorySuccessState(categories));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  void getProducts(int categoryId) async {
    emit(ProductLoadingState());
    try {
      final products = await homeService.getProducts(categoryId);
      emit(ProductSuccessState(products));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
