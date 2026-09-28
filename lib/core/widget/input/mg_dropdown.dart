import 'package:flutter/material.dart';

import '../../constants/app_numbers.dart';
import '../../helpers/app_colors.dart';

/// Selector reutilizable — mismo estilo que [MgInput], pero además fuerza el
/// color del menú desplegable (`dropdownColor`) y del texto de cada opción.
/// Sin esto, el popup de [DropdownButtonFormField] usa colores por defecto
/// de Material que no siguen el tema de la app y se ven fuera de lugar en
/// modo oscuro (fondo claro con texto oscuro sobre una app oscura).
///
/// ```dart
/// MgDropdown<String>(
///   label: 'Método de pago',
///   value: paymentMethod,
///   items: methods.map((m) => MgDropdownItem(value: m.value, label: m.label)).toList(),
///   onChanged: (v) => ctrl.setPaymentMethod(v),
/// )
/// ```
class MgDropdownItem<T> {
  const MgDropdownItem({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}

class MgDropdown<T> extends StatelessWidget {
  const MgDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
  });

  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final T? value;
  final List<MgDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kRadiusMd),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kRadiusMd),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    );

    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      onChanged: enabled ? onChanged : null,
      // Sin esto el popup se ve blanco/gris genérico, fuera del tema oscuro.
      dropdownColor: colorScheme.surfaceContainer,
      icon: Icon(Icons.keyboard_arrow_down_rounded,
          color: colorScheme.onSurfaceVariant),
      style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: enabled ? colorScheme.surface : colorScheme.surfaceContainer,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 20, color: colorScheme.onSurfaceVariant)
            : null,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        disabledBorder: border,
        contentPadding: kSpaceDeviceHVSm,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
      ),
      items: items
          .map(
            (i) => DropdownMenuItem<T>(
              value: i.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (i.icon != null) ...[
                    Icon(i.icon, size: 18, color: colorScheme.onSurfaceVariant),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      i.label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
