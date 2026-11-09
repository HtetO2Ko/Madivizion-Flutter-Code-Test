import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'auth_progress_indicator.dart';

class AuthHeader extends StatelessWidget {
  final int currentStep;
  final VoidCallback onBack;

  const AuthHeader({
    super.key,
    required this.currentStep,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 58,
          height: 58,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),

        AuthProgressIndicator(currentStep: currentStep),
      ],
    );
  }
}
