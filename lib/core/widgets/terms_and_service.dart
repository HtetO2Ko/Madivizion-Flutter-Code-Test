import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TermsAndService extends StatelessWidget {
  const TermsAndService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text.rich(
        TextSpan(
          style: AppTextStyles.caption,
          children: [
            const TextSpan(
              text:
                  'By continuing, you acknowledge that you have read '
                  'and agree to our ',
            ),
            TextSpan(
              text: 'Terms of Use',
              style: const TextStyle(color: AppColors.secondary),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushNamed(
                    AppRouteNames.placeSheet,
                    queryParameters: {'page': "Terms of Use"},
                  );
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy.',
              style: const TextStyle(color: AppColors.secondary),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushNamed(
                    AppRouteNames.placeSheet,
                    queryParameters: {'page': "Privacy Policy"},
                  );
                },
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
