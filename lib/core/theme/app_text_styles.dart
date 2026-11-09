import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings
  static const heading = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const subheading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Body
  static const body = TextStyle(fontSize: 14, color: AppColors.textPrimary);

  static const caption = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  static const input = TextStyle(fontSize: 19, color: AppColors.textPrimary);

  static const label = TextStyle(fontSize: 13, color: AppColors.textSecondary);
}
