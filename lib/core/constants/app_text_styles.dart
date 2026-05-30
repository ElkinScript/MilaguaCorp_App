import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';

/// Estilos de texto estándar de Milagua.
///
/// Uso:
/// ```dart
/// Text('Total', style: MgTextStyles.labelMuted)
/// Text('\$12.50',  style: MgTextStyles.totalAmount)
/// ```
class MgTextStyles {
  MgTextStyles._();

  // ──────────────────────────────────────────────────────────────────
  // Títulos
  // ──────────────────────────────────────────────────────────────────

  static const TextStyle pageTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // ──────────────────────────────────────────────────────────────────
  // Cuerpo
  // ──────────────────────────────────────────────────────────────────

  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  // ──────────────────────────────────────────────────────────────────
  // Labels / captions
  // ──────────────────────────────────────────────────────────────────

  static const TextStyle labelMuted = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle labelBold = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.gray,
  );

  // ──────────────────────────────────────────────────────────────────
  // Precios / totales
  // ──────────────────────────────────────────────────────────────────

  static const TextStyle price = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static const TextStyle totalAmount = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  static const TextStyle priceSm = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // ──────────────────────────────────────────────────────────────────
  // Botones
  // ──────────────────────────────────────────────────────────────────

  static const TextStyle btnLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle btnLabelOutline = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // ──────────────────────────────────────────────────────────────────
  // Estados / badges
  // ──────────────────────────────────────────────────────────────────

  static const TextStyle badgeSuccess = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  static const TextStyle badgeError = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.error,
  );

  static const TextStyle badgeWarning = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.warning,
  );
}
