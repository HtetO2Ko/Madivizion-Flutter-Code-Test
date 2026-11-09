import '../../domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.tier,
    required super.points,
    required super.nextTier,
    required super.pointsToNextTier,
    required super.notificationCount,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as int,
      tier: json['tier'] as String,
      points: json['points'] as int,
      nextTier: json['nextTier'] as String,
      pointsToNextTier: json['pointsToNextTier'] as int,
      notificationCount: json['notificationCount'] as int,
    );
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'] as int,
      tier: map['tier'] as String,
      points: map['points'] as int,
      nextTier: map['next_tier'] as String,
      pointsToNextTier: map['points_to_next_tier'] as int,
      notificationCount: map['notification_count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tier': tier,
      'points': points,
      'next_tier': nextTier,
      'points_to_next_tier': pointsToNextTier,
      'notification_count': notificationCount,
    };
  }
}
