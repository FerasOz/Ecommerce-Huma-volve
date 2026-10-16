import 'package:ecommerce_app_huma_volve/core/routes/app_routers.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_loader_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repository/home_repository_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/source/remote_home_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static final GetProductByIdUseCase _getProductByIdUseCase =
      GetProductByIdUseCase(
        HomeRepositoryImpl(RemoteHomeDataSourceImpl(DioHelper())),
      );

  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: 'productDetails',
        path: AppRoutes.productDetailsScreen,
        builder: (context, state) {
          final productId = int.tryParse(state.pathParameters['id'] ?? '');
          if (productId == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid product ID')),
            );
          }
          return ProductDetailsLoaderScreen(
            productFuture: _getProductByIdUseCase.invoke(productId),
          );
        },
      ),
    ],
  );
}
