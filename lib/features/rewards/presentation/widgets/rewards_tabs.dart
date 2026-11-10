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
          final eatWidth = constraints.maxWidth * 0.7;
          final giftWidth = constraints.maxWidth * 0.3;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                left: selectedIndex == 0 ? 0 : eatWidth,
                top: 0,
                bottom: 0,
                width: selectedIndex == 0 ? eatWidth : giftWidth,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(flex: 7, child: _buildTab('Eat more earn more', 0)),
                  Expanded(flex: 3, child: _buildTab('Gift', 1)),
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
        child: SizedBox.expand(
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeOut,
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
      ),
    );
  }
}
