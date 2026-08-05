import 'dart:io';

import 'package:flutter/material.dart';
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
  File? _pickedImage;
  bool _saving = false;

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
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
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

  @override
  Widget build(BuildContext context) {
    final user = _currentUser;
    final colorScheme = Theme.of(context).colorScheme;

    return MgBottomSheet(
      title: 'Editar perfil',
      scrollable: false,
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
            const Gap(8),
          ],
        );
      },
    );
  }
}
