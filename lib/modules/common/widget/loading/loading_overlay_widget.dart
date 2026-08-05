import 'package:flutter/material.dart';

import '../../../../core/helpers/app_colors.dart';
class LoadingOverlayWidget extends StatelessWidget {
  const LoadingOverlayWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
      ),
    );
  }
}
