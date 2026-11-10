import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RewardsTabs extends StatelessWidget {
  const RewardsTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 310,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          // Exactly 70% for Tab 0, 30% for Tab 1
          final tab0Width = totalWidth * 0.7;
          final tab1Width = totalWidth * 0.3;

          return Stack(
            children: [
              // Sliding background indicator
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                left: selectedIndex == 0 ? 0 : tab0Width,
                top: 0,
                bottom: 0,
                width: selectedIndex == 0 ? tab0Width : tab1Width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              // Interactive tap targets
              Row(
                children: [
                  SizedBox(
                    width: tab0Width,
                    child: _buildTab('Eat more earn more', 0),
                  ),
                  SizedBox(width: tab1Width, child: _buildTab('Gift', 1)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          if (selectedIndex != index) {
            onChanged(index);
          }
        },
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
