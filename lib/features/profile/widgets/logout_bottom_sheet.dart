import 'package:ecommerce_app_huma_volve/core/helpers/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_helper.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/repository/login_repository_impl.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/source/remote_login_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Container(width: 64, height: 2, color: Colors.grey)),
          SizedBox(height: 8),
          Text(
            "Logout",
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontSize: 24),
          ),
          SizedBox(height: 16),
          Text(
            "Are you sure you want to log out?",
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              SecureStorage.deleteTokens();
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BlocProvider(
                        create: (_) => LoginCubit(
                          loginUseCase: LoginUseCase(
                            LoginRepositoryImpl(
                              RemoteLoginDataSourceImpl(dioHelper: DioHelper()),
                            ),
                          ),
                        ),
                        child: const LoginScreen(),
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                ),
              );
            },
            child: Text(
              "Yes, log out",
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No, stay logged in",
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
