import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/app_numbers.dart';
import '../../helpers/app_colors.dart';

/// Bottom sheet base reutilizable — equivalente a BaseBottomSheet del Support.
///
/// ```dart
/// // Uso simple
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   backgroundColor: Colors.transparent,
///   builder: (_) => MgBottomSheet(
///     title: 'Mi título',
///     child: MyContent(),
///   ),
/// );
///
/// // Con DraggableScrollableSheet
/// MgBottomSheet(
///   title: 'Nueva venta',
///   scrollable: true,
///   child: MyScrollableList(),
/// )
/// ```
class MgBottomSheet extends StatelessWidget {
  const MgBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.action,
    this.initialHeightFactor = kSheetHeightLg,
    this.scrollable = false,
    this.onClose,
    this.padding,
    this.backgroundColor,
  });

  final String? title;
  final String? subtitle;
  final Widget? child;

  /// Widget opcional junto al botón cerrar (ej. un botón de acción secundaria)
  final Widget? action;

  /// Factor de altura inicial (0.0 – 1.0). Usa las constantes kSheetHeight*.
  final double initialHeightFactor;

  /// true → envuelve en DraggableScrollableSheet
  final bool scrollable;

  final VoidCallback? onClose;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (scrollable) {
      return DraggableScrollableSheet(
        initialChildSize: initialHeightFactor,
        minChildSize: 0.35,
        maxChildSize: 0.95,
        builder: (ctx, scrollController) =>
            _buildContainer(ctx, scrollController: scrollController),
      );
    }
    return FractionallySizedBox(
      heightFactor: initialHeightFactor,
      child: _buildContainer(context),
    );
  }

  Widget _buildContainer(BuildContext context,
      {ScrollController? scrollController}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceLow,
        borderRadius: kBorderRadiusTopXl,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            if (title != null) ...[
              _buildHeader(context),
              const Divider(height: 1, color: AppColors.outline),
            ],
            if (child != null)
              Expanded(
                child: Padding(
                  padding: padding ?? kSpaceDeviceMd,
                  child: child!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.grayLight,
            borderRadius: BorderRadius.circular(kRadiusCircular),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
                if (subtitle != null) ...[
                  const Gap(separatorXs),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) ...[
            action!,
            const Gap(separatorXs),
          ],
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primarySubtle,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 18, color: AppColors.primary),
            ),
            onPressed: onClose ?? () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
