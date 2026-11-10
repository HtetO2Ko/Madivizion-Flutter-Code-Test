import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.radius = AppRadius.sm,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.surfaceMuted,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
    children: [
      const AppSkeleton(height: 190, radius: 0),
      const SizedBox(height: AppSpacing.lg),
      for (var section = 0; section < 3; section++) ...[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: AppSkeleton(width: 150, height: 22),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (_, __) => const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSkeleton(width: 150, height: 125, radius: AppRadius.md),
                SizedBox(height: AppSpacing.sm),
                AppSkeleton(width: 110, height: 14),
              ],
            ),
          ),
        ),
      ],
    ],
  );
}

class SectionMessage extends StatelessWidget {
  const SectionMessage({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Center(
      child: Column(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 28),
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    ),
  );
}

class SectionErrorMessage extends StatelessWidget {
  const SectionErrorMessage({
    super.key,
    this.message = 'This section could not be loaded.',
  });

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Center(
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 26),
          const SizedBox(height: AppSpacing.sm),
          Text(message, textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    ),
  );
}
