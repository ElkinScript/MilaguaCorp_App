import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Constantes de color — úsalas directamente en const TextStyle / const BoxDecoration
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  // Primario (azul marino Milagua)
  static const Color primary       = Color(0xFF1B3A5C);
  static const Color primaryDark   = Color(0xFF102A43);
  static const Color primaryLight  = Color(0xFFB9C9DC);
  static const Color primarySubtle = Color(0xFFEEF1F6);

  // Superficie
  static const Color surface              = Colors.white;
  static const Color surfaceLow          = Color(0xFFf8fafc);
  static const Color surfaceContainer    = Color(0xFFf1f5f9);
  static const Color onSurface          = Color(0xFF1e293b);
  static const Color onSurfaceVariant   = Color(0xFF64748b);

  // Borde
  static const Color outline        = Color(0xFFe2e8f0);
  static const Color outlineFocus   = Color(0xFF1B3A5C);

  // Estado
  static const Color success = Color(0xFF22c55e);
  static const Color successLight = Color(0xFFdcfce7);
  static const Color error   = Color(0xFFef4444);
  static const Color errorLight   = Color(0xFFfee2e2);
  static const Color warning = Color(0xFFf59e0b);
  static const Color warningLight = Color(0xFFfef3c7);
  static const Color info    = Color(0xFF3b82f6);

  // Neutros
  static const Color gray      = Color(0xFF94a3b8);
  static const Color grayLight = Color(0xFFcbd5e1);
  static const Color white     = Colors.white;
  static const Color black     = Colors.black;
  static const Color transparent = Colors.transparent;

  // Texto en AppBar / sobre primario
  static const Color onPrimary = Colors.white;
}

// ─────────────────────────────────────────────────────────────────────────────
// ColorScheme — para ThemeData
// ─────────────────────────────────────────────────────────────────────────────
class AppColorScheme extends ColorScheme {
  const AppColorScheme()
      : super(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.primaryDark,
          onSecondary: AppColors.onPrimary,
          error: AppColors.error,
          onError: AppColors.onPrimary,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          onSurfaceVariant: AppColors.onSurfaceVariant,
          surfaceContainerLowest: AppColors.surfaceLow,
          surfaceContainerLow: AppColors.surfaceContainer,
          surfaceContainer: AppColors.outline,
          outline: AppColors.outlineFocus,
          outlineVariant: AppColors.outline,
          inverseSurface: AppColors.onSurface,
          onInverseSurface: AppColors.surfaceLow,
          scrim: Colors.black,
          shadow: Colors.black,
        );
}
