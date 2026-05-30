import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/app_numbers.dart';
import '../../helpers/app_colors.dart';

/// Botón principal de Milagua — equivalente a BtnSolid del Support.
///
/// ```dart
/// MgBtn(label: 'Guardar',   onTap: _save)
/// MgBtn(label: 'Cancelar',  onTap: _cancel, isOutline: true)
/// MgBtn(label: 'Cargando',  onTap: _save,   isLoading: true)
/// MgBtn(label: 'Exportar',  onTap: _export, icon: Icons.download, size: MgBtnSize.sm)
/// ```
enum MgBtnSize { sm, md, lg }

class MgBtn extends StatelessWidget {
  const MgBtn({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.isOutline = false,
    this.color,
    this.textColor,
    this.radius = kBtnRadiusMd,
    this.padding,
    this.icon,
    this.size = MgBtnSize.md,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isOutline;
  final Color? color;
  final Color? textColor;
  final double radius;
  final EdgeInsets? padding;
  final IconData? icon;
  final MgBtnSize size;

  /// Si false, el botón solo ocupa el ancho mínimo (para botones en fila)
  final bool expand;

  EdgeInsets get _padding {
    if (padding != null) return padding!;
    return switch (size) {
      MgBtnSize.sm => const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      MgBtnSize.md => const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      MgBtnSize.lg => const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
    };
  }

  double get _fontSize => switch (size) {
        MgBtnSize.sm => 13,
        MgBtnSize.md => 15,
        MgBtnSize.lg => 17,
      };

  @override
  Widget build(BuildContext context) {
    final bg = color ?? (isOutline ? AppColors.surface : AppColors.primary);
    final fg = textColor ?? (isOutline ? AppColors.primary : AppColors.onPrimary);

    final btn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: isOutline ? 0 : 2,
        padding: _padding,
        minimumSize: size == MgBtnSize.sm ? const Size(0, 36) : const Size(0, kBtnHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: isOutline
              ? BorderSide(color: color ?? AppColors.primary, width: 1.5)
              : BorderSide.none,
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: fg,
                strokeWidth: 2,
              ),
            )
          : icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: _fontSize + 3, color: fg),
                    const Gap(separatorSm),
                    Text(
                      label,
                      style: TextStyle(
                        color: fg,
                        fontWeight: FontWeight.w600,
                        fontSize: _fontSize,
                      ),
                    ),
                  ],
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w600,
                    fontSize: _fontSize,
                  ),
                ),
    );

    return expand ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
