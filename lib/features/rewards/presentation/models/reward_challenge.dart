enum ChallengeType { donut, coffee }

class RewardChallenge {
  final String id;
  final String title;
  final int progress;
  final int target;
  final int rewardPoints;
  final ChallengeType type;

  const RewardChallenge({
    required this.id,
    required this.title,
    required this.progress,
    required this.target,
    required this.rewardPoints,
    required this.type,
  });

  bool get isCompleted => progress >= target;
}
