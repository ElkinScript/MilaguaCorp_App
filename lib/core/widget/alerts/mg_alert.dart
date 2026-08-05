import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../constants/app_numbers.dart';
import '../../helpers/app_colors.dart';
import '../buttons/mg_btn.dart';

/// Diálogo de alerta/confirmación reutilizable — equivalente a GeneralAlert del Support.
///
/// ```dart
/// // Confirmación con dos botones
/// showDialog(
///   context: context,
///   builder: (_) => MgAlert(
///     title: '¿Eliminar venta?',
///     content: 'Esta acción no se puede deshacer.',
///     icon: Icons.delete_outline,
///     iconColor: AppColors.error,
///     onConfirm: () async { await _delete(); },
///   ),
/// );
///
/// // Solo confirmación (sin cancelar)
/// MgAlert(
///   title: 'Venta registrada',
///   icon: Icons.check_circle_outline,
///   onlyConfirmation: true,
///   confirmLabel: 'Entendido',
///   onConfirm: () async { Navigator.pop(context); },
/// )
/// ```
class MgAlert extends StatefulWidget {
  const MgAlert({
    super.key,
    required this.title,
    this.content,
    this.child,
    this.icon,
    this.iconColor,
    this.cancelLabel = 'Cancelar',
    this.confirmLabel = 'Confirmar',
    required this.onConfirm,
    this.onCancel,
    this.onlyConfirmation = false,
  });

  final String title;
  final String? content;
  final Widget? child;
  final IconData? icon;
  final Color? iconColor;
  final String cancelLabel;
  final String confirmLabel;
  final Future<void> Function() onConfirm;
  final Future<void> Function()? onCancel;
  final bool onlyConfirmation;

  @override
  State<MgAlert> createState() => _MgAlertState();
}

class _MgAlertState extends State<MgAlert> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LoadingOverlay(
      isLoading: _loading,
      color: Colors.black45,
      child: Dialog(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusLg)),
        child: Padding(
          padding: kSpaceDeviceLg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: kIconXl,
                  color: widget.iconColor ?? AppColors.primary,
                ),
                const Gap(separatorMd),
              ],
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.content != null) ...[
                const Gap(separatorSm),
                Text(
                  widget.content!,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (widget.child != null) ...[
                const Gap(separatorSm),
                widget.child!,
              ],
              const Gap(separatorLg),
              Row(
                children: [
                  if (!widget.onlyConfirmation) ...[
                    Expanded(
                      child: MgBtn(
                        label: widget.cancelLabel,
                        isOutline: true,
                        onTap: _loading
                            ? null
                            : () async {
                                if (widget.onCancel != null) {
                                  setState(() => _loading = true);
                                  await widget.onCancel!();
                                  if (mounted) setState(() => _loading = false);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                      ),
                    ),
                    const Gap(separatorSm),
                  ],
                  Expanded(
                    child: MgBtn(
                      label: widget.confirmLabel,
                      isLoading: _loading,
                      onTap: _loading
                          ? null
                          : () async {
                              setState(() => _loading = true);
                              await widget.onConfirm();
                              if (mounted) setState(() => _loading = false);
                            },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
