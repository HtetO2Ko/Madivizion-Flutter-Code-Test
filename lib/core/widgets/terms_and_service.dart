import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TermsAndService extends StatelessWidget {
  const TermsAndService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text.rich(
        const TextSpan(
          style: AppTextStyles.caption,
          children: [
            TextSpan(
              text:
                  'By continuing, you acknowledge that you have read '
                  'and agree to our ',
            ),
            TextSpan(
              text: 'Terms of Use',
              style: TextStyle(color: AppColors.secondary),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy.',
              style: TextStyle(color: AppColors.secondary),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
