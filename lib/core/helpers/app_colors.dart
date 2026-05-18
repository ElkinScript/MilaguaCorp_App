import 'package:flutter/material.dart';

const Color _primary = Color(0xFF0ea5c8);
const Color _primaryDark = Color(0xFF0b8aa8);
const Color _primaryLight = Color(0xFFb3e8f5);
const Color _onPrimary = Colors.white;
const Color _secondary = Color(0xFF06b6d4);
const Color _onSecondary = Colors.white;
const Color _surface = Colors.white;
const Color _onSurface = Color(0xFF1e293b);
const Color _onSurfaceVariant = Color(0xFF64748b);
const Color _surfaceContainerLowest = Color(0xFFf8fafc);
const Color _surfaceContainerLow = Color(0xFFe2e8f0);
const Color _surfaceContainer = Color(0xFFcbd5e1);
const Color _outline = Color(0xFF0ea5c8);
const Color _outlineNeutral = Color(0xFFe2e8f0);
const Color _error = Color(0xFFef4444);
const Color _onError = Colors.white;
const Color _success = Color(0xFF22c55e);
const Color _warning = Color(0xFFf59e0b);
const Color _inverseSurface = Color(0xFF1e293b);
const Color _onInverseSurface = Color(0xFFf8fafc);

class AppColorScheme extends ColorScheme {
  const AppColorScheme()
      : super(
          brightness: Brightness.light,
          primary: _primary,
          onPrimary: _onPrimary,
          secondary: _secondary,
          onSecondary: _onSecondary,
          error: _error,
          onError: _onError,
          surface: _surface,
          onSurface: _onSurface,
          onSurfaceVariant: _onSurfaceVariant,
          surfaceContainerLowest: _surfaceContainerLowest,
          surfaceContainerLow: _surfaceContainerLow,
          surfaceContainer: _surfaceContainer,
          outline: _outline,
          outlineVariant: _outlineNeutral,
          inverseSurface: _inverseSurface,
          onInverseSurface: _onInverseSurface,
          scrim: Colors.black,
          shadow: Colors.black,
        );
}

class AppColors {
  Color get primary => _primary;
  Color get primaryDark => _primaryDark;
  Color get primaryLight => _primaryLight;
  Color get onPrimary => _onPrimary;
  Color get secondary => _secondary;
  Color get surface => _surface;
  Color get onSurface => _onSurface;
  Color get onSurfaceVariant => _onSurfaceVariant;
  Color get surfaceContainerLowest => _surfaceContainerLowest;
  Color get surfaceContainerLow => _surfaceContainerLow;
  Color get outlineNeutral => _outlineNeutral;
  Color get error => _error;
  Color get success => _success;
  Color get warning => _warning;
  Color get white => Colors.white;
  Color get black => Colors.black;
  Color get gray => const Color(0xFF94a3b8);
  Color get grayWhite => const Color(0xFFf1f5f9);
}
