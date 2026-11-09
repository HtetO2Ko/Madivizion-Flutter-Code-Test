import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class AuthProgressIndicator extends StatelessWidget {
  final int currentStep;

  const AuthProgressIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: currentStep == 4
          ? BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(23),
            )
          : null,
      child: currentStep == 4
          ? Icon(Icons.check, size: 22, color: Colors.white)
          : CircularProgressIndicator(
              value: currentStep / 4,
              strokeWidth: 9,
              backgroundColor: AppColors.primary.withValues(alpha: 0.35),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.secondary,
              ),
            ),
    );
  }
}
