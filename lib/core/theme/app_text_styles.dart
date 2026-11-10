import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const heading = TextStyle(
    fontSize: 27, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, height: 1.2,
  );
  static const headingLarge = TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, height: 1.15,
  );
  static const title = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary, height: 1.25,
  );
  static const subheading = TextStyle(
    fontSize: 14, fontWeight: FontWeight.normal,
    color: AppColors.textSecondary, height: 1.5,
  );
  static const body = TextStyle(
    fontSize: 14, color: AppColors.textPrimary, height: 1.45,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16, color: AppColors.textPrimary, height: 1.45,
  );
  static const caption = TextStyle(
    fontSize: 11, color: AppColors.textSecondary, height: 1.4,
  );
  static const label = TextStyle(
    fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500,
  );
  static const button = TextStyle(
    fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1,
  );
  static const input = TextStyle(fontSize: 17, color: AppColors.textPrimary);
  static const error = TextStyle(
    fontSize: 13, color: AppColors.error, height: 1.4,
  );
}
