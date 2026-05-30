import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';

import '../core/constants/themes/app_theme.dart';
import 'app_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Main Navigator');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppModule.router,
      title: 'Milagua Corp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getThemeData(context),
      // ── Integración con DevicePreview ────────────────────────
      // Permite cambiar el tamaño del dispositivo (móvil / tablet / PC)
      // desde el panel lateral en modo debug. Se desactiva en release.
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
