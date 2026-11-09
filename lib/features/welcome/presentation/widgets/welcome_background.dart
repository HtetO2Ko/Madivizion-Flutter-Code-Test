import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.authBackgroundTop,
      child: Column(
        children: [
          Expanded(
            flex: 70,
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
                'assets/images/welcome.png',
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const Expanded(
            flex: 30,
            child: ColoredBox(color: AppColors.authBackground),
          ),
        ],
      ),
    );
  }
}
