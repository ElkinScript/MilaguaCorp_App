import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeModeKey = 'mg_theme_mode';

final themeModeControllerProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>((ref) {
  return ThemeModeController();
});

// Claro / oscuro / sistema — un solo ícono en el header que cicla entre los 3.
// Por defecto (primera vez, sin elección guardada) sigue el tema del dispositivo.
class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController() : super(ThemeMode.system) {
    _restore();
  }

  bool _userSet = false;

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    // Si el usuario ya eligió un tema mientras esto cargaba, no lo pisamos.
    if (_userSet) return;
    final saved = prefs.getString(_kThemeModeKey);
    state = switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> _set(ThemeMode mode) async {
    _userSet = true;
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeModeKey, mode.name);
  }

  Future<void> setLight() => _set(ThemeMode.light);
  Future<void> setDark() => _set(ThemeMode.dark);
  Future<void> setSystem() => _set(ThemeMode.system);

  Future<void> cycle() {
    final next = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    return _set(next);
  }
}
