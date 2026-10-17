import 'package:ecommerce_app_huma_volve/core/routes/router_generation_config.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ecommerce_app_huma_volve/features/cart/data/source/local_cart_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/add_cart_item_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/remove_cart_item_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/domain/use_cases/update_cart_item_quantity_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final cartBox = await Hive.openBox<String>(LocalCartDataSourceImpl.boxName);
  final CartRepository cartRepository = CartRepositoryImpl(
    LocalCartDataSourceImpl(cartBox),
  );

  runApp(
    BlocProvider(
      create: (_) => CartCubit(
        getCartItemsUseCase: GetCartItemsUseCase(cartRepository),
        addCartItemUseCase: AddCartItemUseCase(cartRepository),
        updateCartItemQuantityUseCase: UpdateCartItemQuantityUseCase(
          cartRepository,
        ),
        removeCartItemUseCase: RemoveCartItemUseCase(cartRepository),
      )..loadCart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: RouterGenerationConfig.goRouter,
    );
  }
}
