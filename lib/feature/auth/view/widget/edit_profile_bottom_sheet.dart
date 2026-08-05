import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widget/mg_widgets.dart';
import '../../domain/user_model.dart';
import '../controller/auth_controller.dart';

class EditProfileBottomSheet extends ConsumerStatefulWidget {
  const EditProfileBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ProviderScope(child: EditProfileBottomSheet()),
    );
  }

  @override
  ConsumerState<EditProfileBottomSheet> createState() =>
      _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState
    extends ConsumerState<EditProfileBottomSheet> {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  File? _pickedImage;
  bool _saving = false;
  bool _savingPassword = false;
  bool _showPasswordSection = false;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  UserModel? get _currentUser => ref
      .read(authControllerProvider)
      .mapOrNull(authenticated: (s) => s.user);

  @override
  void initState() {
    super.initState();
    final user = _currentUser;
    _firstNameCtrl = TextEditingController(text: user?.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: user?.lastName ?? '');
    _emailCtrl = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picked = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (picked != null) {
        setState(() => _pickedImage = File(picked.path));
      }
    } on PlatformException catch (e) {
      if (!mounted) return;
      MgToast.error(
        context,
        e.code == 'photo_access_denied'
            ? 'No tienes permiso para acceder a tus fotos. Actívalo en Ajustes.'
            : 'No se pudo abrir la galería: ${e.message ?? e.code}',
      );
    } catch (e) {
      if (!mounted) return;
      MgToast.error(context, 'No se pudo abrir la galería. Intenta de nuevo.');
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final error =
        await ref.read(authControllerProvider.notifier).updateProfile(
              firstName: _firstNameCtrl.text.trim(),
              lastName: _lastNameCtrl.text.trim(),
              email: _emailCtrl.text.trim(),
              profilePicture: _pickedImage,
            );
    if (!mounted) return;
    setState(() => _saving = false);
    if (error != null) {
      MgToast.error(context, error);
    } else {
      MgToast.success(context, 'Perfil actualizado correctamente');
      Navigator.pop(context);
    }
  }

  Future<void> _savePassword() async {
    final next = _newPasswordCtrl.text;
    final confirm = _confirmPasswordCtrl.text;
    if (next.isEmpty || confirm.isEmpty) {
      MgToast.warning(context, 'Completa los 2 campos de contraseña');
      return;
    }
    if (next != confirm) {
      MgToast.warning(
        context,
        'La nueva contraseña y su confirmación no coinciden',
      );
      return;
    }
    setState(() => _savingPassword = true);
    final error =
        await ref.read(authControllerProvider.notifier).changePassword(
              newPassword: next,
              confirmPassword: confirm,
            );
    if (!mounted) return;
    setState(() => _savingPassword = false);
    if (error != null) {
      MgToast.error(context, error);
    } else {
      MgToast.success(context, 'Contraseña actualizada correctamente');
      _newPasswordCtrl.clear();
      _confirmPasswordCtrl.clear();
      setState(() => _showPasswordSection = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _currentUser;
    final colorScheme = Theme.of(context).colorScheme;

    return MgBottomSheet(
      title: 'Editar perfil',
      scrollable: false,
      showCloseButton: false,
      initialHeightFactor: 0.72,
      childBuilder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 72,
                    backgroundColor: AppColors.primaryLight,
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage!)
                        : ((user?.profilePicture ?? '').isNotEmpty
                            ? NetworkImage(user!.profilePicture!)
                                as ImageProvider
                            : null),
                    child: _pickedImage == null &&
                            (user?.profilePicture ?? '').isEmpty
                        ? Text(
                            user?.initials ?? '?',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: colorScheme.surface, width: 3),
                        ),
                        child: const Icon(Icons.edit,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(32),
            MgInput(
              controller: _firstNameCtrl,
              label: 'Nombres',
              prefixIcon: Icons.person_outline,
              textInputAction: TextInputAction.next,
            ),
            const Gap(12),
            MgInput(
              controller: _lastNameCtrl,
              label: 'Apellidos',
              prefixIcon: Icons.person_outline,
              textInputAction: TextInputAction.next,
            ),
            const Gap(12),
            MgInput(
              controller: _emailCtrl,
              label: 'Correo electrónico',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
            ),
            const Gap(24),
            MgBtn(
              label: 'Guardar cambios',
              isLoading: _saving,
              onTap: _saving ? null : _save,
            ),
            const Gap(24),
            Divider(color: colorScheme.outlineVariant),
            InkWell(
              onTap: () =>
                  setState(() => _showPasswordSection = !_showPasswordSection),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.lock_outline,
                        size: 20, color: colorScheme.primary),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Icon(
                      _showPasswordSection
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            if (_showPasswordSection) ...[
              const Gap(4),
              MgInput(
                controller: _newPasswordCtrl,
                label: 'Nueva contraseña',
                prefixIcon: Icons.lock_reset_outlined,
                obscureText: _obscureNew,
                textInputAction: TextInputAction.next,
                suffixIcon: IconButton(
                  icon: Icon(_obscureNew
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                ),
              ),
              const Gap(12),
              MgInput(
                controller: _confirmPasswordCtrl,
                label: 'Confirmar nueva contraseña',
                prefixIcon: Icons.lock_reset_outlined,
                obscureText: _obscureConfirm,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
              const Gap(16),
              MgBtn(
                label: 'Actualizar contraseña',
                isLoading: _savingPassword,
                isOutline: true,
                onTap: _savingPassword ? null : _savePassword,
              ),
            ],
            const Gap(8),
          ],
        );
      },
    );
  }
}
