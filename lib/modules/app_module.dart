import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/view/widget/login_screen.dart';
import '../feature/dashboard/view/widget/home_screen.dart';
import '../feature/product/view/widget/product_screen.dart';
import '../feature/sale/view/widget/sale_screen.dart';

class AppModule {
  AppModule._();

  static final router = GoRouter(
    initialLocation: LoginScreen.routeName,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: LoginScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: SaleScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const SaleScreen(),
      ),
      GoRoute(
        path: ProductScreen.routeName,
        builder: (BuildContext context, GoRouterState state) =>
            const ProductScreen(),
      ),
    ],
  );
}
