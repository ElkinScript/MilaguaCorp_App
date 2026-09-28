import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/themes/app_theme.dart';
import '../core/theme/theme_mode_controller.dart';
import 'app_module.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Main Navigator');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);

    return MaterialApp.router(
      routerConfig: ref.watch(appRouterProvider),
      title: 'Milagua Corp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getThemeData(context),
      darkTheme: AppTheme().getDarkThemeData(context),
      themeMode: themeMode,
      // ── Integración con DevicePreview ────────────────────────
      // Permite cambiar el tamaño del dispositivo (móvil / tablet / PC)
      // desde el panel lateral en modo debug. Se desactiva en release.
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
