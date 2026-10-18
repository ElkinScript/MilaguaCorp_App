import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/view/controller/auth_controller.dart';
import '../feature/auth/view/state/auth_state.dart';
import '../feature/auth/view/widget/login_screen.dart';
import '../feature/auth/view/widget/splash_screen.dart';
import '../feature/dashboard/view/widget/home_screen.dart';
import '../feature/product/view/widget/product_screen.dart';
import '../feature/proforma/view/widget/proforma_screen.dart';
import '../feature/report/view/widget/report_screen.dart';
import '../feature/sale/domain/sale_model.dart';
import '../feature/sale/view/widget/sale_screen.dart';

/// Router global — se reconstruye la navegación (redirect) cada vez que
/// cambia el AuthState: arranque (splash → home/login), logout y sesión
/// expirada (refresh rechazado → login).
final appRouterProvider = Provider<GoRouter>((ref) {
  final authListenable = ValueNotifier<AuthState>(
    ref.read(authControllerProvider),
  );
  ref.listen<AuthState>(
    authControllerProvider,
    (_, next) => authListenable.value = next,
  );

  final router = AppModule.buildRouter(
    authState: () => authListenable.value,
    refreshListenable: authListenable,
  );
  ref.onDispose(() {
    router.dispose();
    authListenable.dispose();
  });
  return router;
});

class AppModule {
  AppModule._();

  /// Decide a dónde ir según la sesión. Devuelve null si la ruta actual es
  /// válida para el estado.
  ///   - checking      → /splash (restaurando la sesión guardada)
  ///   - authenticated → /home si está en /login o /splash
  ///   - sin sesión    → /login (initial, loading y error del login)
  static String? authRedirect(AuthState auth, String location) {
    return auth.maybeWhen(
      checking: () =>
          location == SplashScreen.routeName ? null : SplashScreen.routeName,
      authenticated: (_) => location == LoginScreen.routeName ||
              location == SplashScreen.routeName
          ? HomeScreen.routeName
          : null,
      orElse: () =>
          location == LoginScreen.routeName ? null : LoginScreen.routeName,
    );
  }

  static GoRouter buildRouter({
    required AuthState Function() authState,
    Listenable? refreshListenable,
  }) {
    return GoRouter(
      initialLocation: SplashScreen.routeName,
      debugLogDiagnostics: false,
      refreshListenable: refreshListenable,
      redirect: (BuildContext context, GoRouterState state) =>
          authRedirect(authState(), state.matchedLocation),
      routes: [
        GoRoute(
          path: SplashScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        ),
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
        GoRoute(
          path: ReportScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const ReportScreen(),
        ),
        GoRoute(
          path: ProformaScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            final sale = state.extra as SaleModel;
            return ProformaScreen(sale: sale);
          },
        ),
      ],
    );
  }
}
