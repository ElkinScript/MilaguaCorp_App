import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_numbers.dart';
import '../../helpers/app_colors.dart';

/// Campo de texto reutilizable — equivalente a InputForm del Support.
///
/// ```dart
/// MgInput(
///   label: 'Nombre del cliente',
///   hint: 'Ej. Juan Pérez',
///   prefixIcon: Icons.person_outline,
///   onChanged: ctrl.setName,
/// )
/// ```
class MgInput extends StatelessWidget {
  const MgInput({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.enabled = true,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.initialValue,
  });

  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int maxLines;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

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
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kRadiusMd),
      borderSide: const BorderSide(color: AppColors.error),
    );

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
      inputFormatters: inputFormatters,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: 14,
        color: colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: enabled ? colorScheme.surface : colorScheme.surfaceContainer,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 20, color: colorScheme.onSurfaceVariant)
            : null,
        suffixIcon: suffixIcon,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        disabledBorder: border,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        contentPadding: kSpaceDeviceHVSm,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6), fontSize: 14),
        errorStyle: const TextStyle(color: AppColors.error, fontSize: 11),
      ),
    );
  }
}
