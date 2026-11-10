import 'package:flutter/material.dart';

class RewardsTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const RewardsTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const double _totalWidth = 310;
  static const double _totalHeight = 48;
  static const double _horizontalPadding = 3;

  @override
  Widget build(BuildContext context) {
    const availableWidth = _totalWidth - (_horizontalPadding * 2);

    const eatTabWidth = availableWidth * 0.7;
    const giftTabWidth = availableWidth * 0.3;

    final indicatorWidth = selectedIndex == 0 ? eatTabWidth : giftTabWidth;

    final indicatorLeft = selectedIndex == 0 ? 0.0 : eatTabWidth;

    return Container(
      height: _totalHeight,
      width: _totalWidth,
      padding: const EdgeInsets.all(_horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: indicatorLeft,
            top: 0,
            bottom: 0,
            width: indicatorWidth,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF55C9E5),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                flex: 7,
                child: _TabItem(
                  title: 'Eat more earn more',
                  isSelected: selectedIndex == 0,
                  onTap: () => onChanged(0),
                ),
              ),
              Expanded(
                flex: 3,
                child: _TabItem(
                  title: 'Gift',
                  isSelected: selectedIndex == 1,
                  onTap: () => onChanged(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : Colors.black54,
            ),
            child: Text(title, textAlign: TextAlign.center, maxLines: 1),
          ),
        ),
      ),
    );
  }
}
