import 'package:flutter/material.dart';

import '../../../../core/widgets/header_button.dart';
import '../../../home/domain/entities/member.dart';
import 'tier_ladder.dart';
import 'points_ring.dart';
import 'rewards_tabs.dart';

class RewardsHeader extends StatelessWidget {
  final Member member;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const RewardsHeader({
    super.key,
    required this.member,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(26, 30, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              // Header title and rewards badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      "J' Donuts Rewards",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1, end: 0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return FractionalTranslation(
                        translation: Offset(value, 0),
                        child: child,
                      );
                    },
                    child: const HeaderButton(
                      count: 3,
                      child: Text(
                        'Rewards',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 38),

              // Tier ladder and points ring
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: TierLadder(member: member)),
                  Expanded(flex: 6, child: PointsRing(member: member)),
                ],
              ),
            ],
          ),
        ),

        // Tabs overlap the bottom edge of the header
        Positioned(
          bottom: 0,
          child: Transform.translate(
            offset: const Offset(0, 24),
            child: RewardsTabs(
              selectedIndex: selectedIndex,
              onChanged: onTabChanged,
            ),
          ),
        ),
      ],
    );
  }
}
