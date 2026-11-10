import 'package:flutter/material.dart';

import '../../../home/domain/entities/member.dart';
import 'shield_badge.dart';

class TierLadder extends StatelessWidget {
  final Member member;

  const TierLadder({super.key, required this.member});

  static const List<String> tiers = ['Bronze', 'Gold', 'Platinum'];

  double get progress {
    final total = member.points + member.pointsToNextTier;

    if (total <= 0) return 0;

    return (member.points / total).clamp(0.0, 1.0);
  }

  int get currentIndex {
    final index = tiers.indexWhere(
      (tier) => tier.toLowerCase() == member.tier.toLowerCase(),
    );

    return index < 0 ? 0 : index;
  }

  BadgeType _getBadgeType(int index) {
    switch (index) {
      case 0:
        return BadgeType.bronze;
      case 1:
        return BadgeType.gold;
      case 2:
        return BadgeType.platinum;
      default:
        return BadgeType.bronze;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(tiers.length, (index) {
        final isCurrent = index == currentIndex;

        final isNext =
            member.nextTier.toLowerCase() == tiers[index].toLowerCase();

        final segmentProgress = index < currentIndex
            ? 1.0
            : index == currentIndex
            ? progress
            : 0.0;

        return SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 42,
                child: Column(
                  children: [
                    // Shield badge
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isCurrent ? 1.0 : 0.55,
                      child: ShieldBadge(type: _getBadgeType(index)),
                    ),

                    // Vertical progress line
                    if (index != tiers.length - 1)
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  width: 3,
                                  height: constraints.maxHeight,
                                  color: Colors.grey.shade200,
                                ),

                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: segmentProgress),
                                  duration: const Duration(milliseconds: 1200),
                                  curve: Curves.easeInOut,
                                  builder: (context, value, child) {
                                    return Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 3,
                                        height: constraints.maxHeight * value,
                                        color: const Color(0xFFE85B5B),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Tier information
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tiers[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isCurrent
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: isCurrent ? Colors.black : Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        isCurrent
                            ? "You're here now"
                            : isNext
                            ? '${member.pointsToNextTier} pts Remaining\nto become ${member.nextTier}'
                            : "You'll be here soon",
                        style: const TextStyle(
                          fontSize: 11,
                          height: 1.3,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
