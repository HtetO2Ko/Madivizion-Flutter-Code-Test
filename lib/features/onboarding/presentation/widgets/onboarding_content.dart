import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/terms_and_service.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.53),

                    const Text(
                      'Round food for\nevery mood',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    _buildLoginSignup(context),

                    const SizedBox(height: 10),

                    _buildThirdPartyAccount(),

                    const SizedBox(height: 20),

                    const TermsAndService(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginSignup(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRouteNames.phoneNumber);
              },
              child: const Text("LET'S GET STARTED"),
            ),
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Already have an account? ',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),

            GestureDetector(
              onTap: () {
                context.pushNamed(AppRouteNames.phoneNumber);
              },
              child: const Text(
                'Log In',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThirdPartyAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('google'),
        const SizedBox(width: 10),
        _buildSocialButton('apple'),
        const SizedBox(width: 10),
        _buildSocialButton('facebook'),
      ],
    );
  }

  Widget _buildSocialButton(String icon) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: Image.asset('assets/icons/$icon.png', width: 26, height: 26),
      ),
    );
  }
}
