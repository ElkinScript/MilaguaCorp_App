import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/flavors/flavors_config.dart';
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
      // Desactivado: simula su propio brillo/tema por encima del real del
      // dispositivo, lo cual pisaba el modo claro/oscuro/sistema de la app.
      // Pruebas siempre en dispositivo físico, así que no aporta nada aquí.
      enabled: false,
      builder: (context) => const ProviderScope(child: AppWidget()),
    ),
  );
}
