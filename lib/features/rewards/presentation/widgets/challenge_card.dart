import 'package:flutter/material.dart';

import '../models/reward_challenge.dart';
import 'challenge_progress_art.dart';
import 'earn_button.dart';

class ChallengeCard extends StatelessWidget {
  final RewardChallenge challenge;
  final int index;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 450 + (index * 150)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 25 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        height: 175,
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Challenge artwork
            Expanded(
              flex: 4,
              child: ChallengeProgressArt(
                type: challenge.type,
                progress: challenge.progress,
                target: challenge.target,
              ),
            ),

            const SizedBox(width: 16),

            // Challenge information
            Expanded(
              flex: 6,
              child: _ChallengeInformation(challenge: challenge),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeInformation extends StatelessWidget {
  final RewardChallenge challenge;

  const _ChallengeInformation({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          challenge.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 9),

        Text(
          '${challenge.progress}/${challenge.target}',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            EarnButton(isCompleted: challenge.isCompleted),

            const SizedBox(width: 12),

            Flexible(
              child: Text(
                '${challenge.rewardPoints} pts',
                maxLines: 1,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
