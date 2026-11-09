import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.authBackgroundTop,
            AppColors.authBackground,
            Colors.white,
          ],
          stops: [0, 0.55, 1],
        ),
      ),
      child: child,
    );
  }
}
