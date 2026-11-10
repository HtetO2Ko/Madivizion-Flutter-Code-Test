import '../models/reward_challenge.dart';

class RewardsStaticData {
  RewardsStaticData._();

  static const List<RewardChallenge> challenges = [
    RewardChallenge(
      id: 'challenge_1',
      title: 'Eat 4 Coco donuts',
      progress: 4,
      target: 4,
      rewardPoints: 100,
      type: ChallengeType.donut,
    ),
    RewardChallenge(
      id: 'challenge_2',
      title: 'Eat 4 Coco donuts',
      progress: 1,
      target: 4,
      rewardPoints: 100,
      type: ChallengeType.donut,
    ),
    RewardChallenge(
      id: 'challenge_3',
      title: 'Drink 12 cups americano',
      progress: 9,
      target: 12,
      rewardPoints: 100,
      type: ChallengeType.coffee,
    ),
  ];

  static const List<RewardChallenge> gifts = [
    RewardChallenge(
      id: 'gift_1',
      title: 'Redeem a free donut',
      progress: 0,
      target: 1,
      rewardPoints: 200,
      type: ChallengeType.donut,
    ),
    RewardChallenge(
      id: 'gift_2',
      title: 'Redeem an americano',
      progress: 0,
      target: 1,
      rewardPoints: 300,
      type: ChallengeType.coffee,
    ),
  ];
}
