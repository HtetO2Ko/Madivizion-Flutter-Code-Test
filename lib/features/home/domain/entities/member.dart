class Member {
  final int id;
  final String tier;
  final int points;
  final String nextTier;
  final int pointsToNextTier;
  final int notificationCount;

  const Member({
    required this.id,
    required this.tier,
    required this.points,
    required this.nextTier,
    required this.pointsToNextTier,
    required this.notificationCount,
  });
}
