import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/helpers/app_colors.dart';

/// Pantalla de arranque mientras se restaura la sesión guardada — evita que
/// se vea el login un instante antes de saltar a /home. La navegación la
/// decide el redirect del router según el AuthState.
class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Milagua Corp',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            Gap(24),
            CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
