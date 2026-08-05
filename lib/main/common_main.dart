import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/flavors/flavors_config.dart';
import '../core/theme/device_preview_brightness_storage.dart';
import '../modules/app_widget.dart';

Future<void> commonMain({
  required String flavor,
  required String baseUrl,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.instance = FlavorConfig(flavor: flavor, baseUrl: baseUrl);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  // Habilita rotación libre para que DevicePreview pueda simular tablet/PC.
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  runApp(
    DevicePreview(
      // El panel de DevicePreview tiene su PROPIO switch claro/oscuro
      // (sección "System"), separado del brillo real del dispositivo.
      // RealBrightnessDevicePreviewStorage lo sincroniza con el brillo real
      // del sistema en cada arranque, para que ThemeMode.system coincida
      // con el dispositivo desde el primer frame. Si se cambia el switch a
      // mano dentro del panel durante la sesión, ese valor manda hasta el
      // próximo arranque (no hay re-sync en vivo si el sistema cambia de
      // tema en caliente con la app abierta).
      enabled: !kReleaseMode,
      storage: RealBrightnessDevicePreviewStorage(
        DevicePreviewStorage.preferences(),
      ),
      builder: (context) => const ProviderScope(child: AppWidget()),
    ),
  );
}
