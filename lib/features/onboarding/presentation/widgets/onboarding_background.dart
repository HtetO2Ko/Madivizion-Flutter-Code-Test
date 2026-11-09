import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.authBackgroundTop,
      child: Column(
        children: [
          Expanded(
            flex: 55,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.transparent],
                  stops: [0.65, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/onboarding.png',
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const Expanded(
            flex: 45,
            child: ColoredBox(color: AppColors.authBackground),
          ),
        ],
      ),
    );
  }
}
