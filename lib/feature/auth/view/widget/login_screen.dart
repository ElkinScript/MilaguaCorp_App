import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../controller/auth_controller.dart';
import '../state/auth_state.dart';

import '../../../../core/helpers/app_colors.dart';
class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    ref
        .read(authControllerProvider.notifier)
        .login(_userCtrl.text.trim(), _passCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authControllerProvider, (_, next) {
      next.maybeWhen(
        authenticated: (_) => context.go('/home'),
        error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        ),
        orElse: () {},
      );
    });

    final isLoading = ref.watch(
      authControllerProvider.select(
        (s) => s.maybeWhen(loading: () => true, orElse: () => false),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo area
                  Column(
                    children: [
                      SizedBox(
                        height: (MediaQuery.sizeOf(context).height * 0.32)
                            .clamp(220, 420),
                        child: Lottie.asset(
                          'assets/lottie/girl_watering_plants.json',
                          repeat: true,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Gap(8),
                      const Text(
                        'Milagua Corp',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const Gap(40),
                  // Username
                  TextFormField(
                    controller: _userCtrl,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Ingresa tu usuario'
                        : null,
                  ),
                  const Gap(16),
                  // Password
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _obscurePass,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePass = !_obscurePass),
                      ),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Ingresa tu contraseña' : null,
                  ),
                  const Gap(32),
                  // Login button
                  ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Ingresar'),
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
