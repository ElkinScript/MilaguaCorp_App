import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/widgets.dart';

/// DevicePreview guarda su propio switch de brillo (claro/oscuro) separado
/// del brillo real del sistema operativo, y por defecto arranca en claro.
/// Esto hace que ThemeMode.system se vea "atascado" en claro aunque el
/// dispositivo esté en oscuro. Este storage envuelve al de DevicePreview y,
/// en cada arranque, sobrescribe isDarkMode con el brillo real del sistema
/// — así "Sistema" coincide con el dispositivo desde el primer frame.
class RealBrightnessDevicePreviewStorage extends DevicePreviewStorage {
  RealBrightnessDevicePreviewStorage(this._delegate);

  final DevicePreviewStorage _delegate;

  @override
  Future<DevicePreviewData?> load() async {
    final saved = await _delegate.load();
    final isSystemDark =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    return (saved ?? const DevicePreviewData())
        .copyWith(isDarkMode: isSystemDark);
  }

  @override
  Future<void> save(DevicePreviewData data) => _delegate.save(data);
}
