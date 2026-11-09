import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PointsProgressLabel extends StatelessWidget {
  final int pointsRemaining;
  final String nextTier;

  const PointsProgressLabel({
    super.key,
    required this.pointsRemaining,
    required this.nextTier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$pointsRemaining points left to become $nextTier Member',
        style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
      ),
    );
  }
}
