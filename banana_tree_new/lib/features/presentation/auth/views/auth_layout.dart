import 'package:banana_tree_new/common/views/app_loading_view.dart';
import 'package:banana_tree_new/features/data/datasources/auth_data_source.dart';
import 'package:banana_tree_new/features/presentation/auth/views/welcome_view.dart';
import 'package:banana_tree_new/features/presentation/home/views/main_view.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});

  final Widget? pageIfNotConnected;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authDataSource,
      builder: (context, authDataSource, child) => StreamBuilder(
        stream: authDataSource.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == .waiting) {
            return const AppLoadingView();
          } else if (snapshot.hasData) {
            return const MainView();
          } else {
            return pageIfNotConnected ?? const WelcomeView();
          }
        },
      ),
    );
  }
}
