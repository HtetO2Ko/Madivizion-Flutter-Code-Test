import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class AppLocalImage extends StatelessWidget {
  const AppLocalImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.image_not_supported_outlined,
    this.borderRadius = AppRadius.md,
  });

  final String? path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final IconData fallbackIcon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final imagePath = path;
    final fallback = _fallback();
    if (imagePath == null || imagePath.isEmpty) return fallback;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.file(
        File(imagePath),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }

  Widget _fallback() => Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    color: AppColors.surfaceMuted,
    child: Icon(fallbackIcon, color: AppColors.textSecondary, size: 34),
  );
}
