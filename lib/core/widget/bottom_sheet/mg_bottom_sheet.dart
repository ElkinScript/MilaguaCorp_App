import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/app_numbers.dart';
import '../../helpers/app_colors.dart';

/// Bottom sheet base reutilizable — mismo look en toda la app (estilo
/// Instagram: manija arriba, título + botón cerrar, contenido abajo).
/// Se adapta a modo claro/oscuro automáticamente.
///
/// ```dart
/// // Uso simple (contenido fijo)
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
/// // Contenido scrolleable (recibe el ScrollController del sheet)
/// MgBottomSheet(
///   title: 'Nueva venta',
///   scrollable: true,
///   childBuilder: (context, scrollController) => MyScrollableList(
///     controller: scrollController,
///   ),
/// )
/// ```
class MgBottomSheet extends StatelessWidget {
  const MgBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.childBuilder,
    this.action,
    this.initialHeightFactor = kSheetHeightLg,
    this.minChildSize = 0.35,
    this.scrollable = false,
    this.onClose,
    this.padding,
    this.backgroundColor,
  }) : assert(childBuilder == null || scrollable,
            'childBuilder debe usarse junto con scrollable: true');

  final String? title;
  final String? subtitle;

  /// Contenido fijo (no scrolleable). Ignorado si [childBuilder] está definido.
  final Widget? child;

  /// Contenido scrolleable — recibe el [ScrollController] del sheet para que
  /// el gesto de arrastrar y el scroll interno funcionen juntos.
  final Widget Function(BuildContext context, ScrollController controller)?
      childBuilder;

  /// Widget opcional junto al botón cerrar (ej. un botón de acción secundaria)
  final Widget? action;

  /// Factor de altura inicial (0.0 – 1.0). Usa las constantes kSheetHeight*.
  final double initialHeightFactor;

  /// Altura mínima (0.0 – 1.0) a la que se puede arrastrar el sheet hacia
  /// abajo. Solo aplica cuando [scrollable] es true.
  final double minChildSize;

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
        minChildSize: minChildSize,
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
    final colorScheme = Theme.of(context).colorScheme;
    final content = childBuilder != null
        ? childBuilder!(context, scrollController ?? ScrollController())
        : child;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surfaceContainerLowest,
        borderRadius: kBorderRadiusTopXl,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(colorScheme),
            if (title != null) ...[
              _buildHeader(context, colorScheme),
              Divider(height: 1, color: colorScheme.outlineVariant),
            ],
            if (content != null)
              Expanded(
                child: Padding(
                  padding: padding ?? kSpaceDeviceMd,
                  child: content,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(kRadiusCircular),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (subtitle != null) ...[
                  const Gap(separatorXs),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
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
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 22, color: AppColors.error),
            ),
            onPressed: onClose ?? () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
