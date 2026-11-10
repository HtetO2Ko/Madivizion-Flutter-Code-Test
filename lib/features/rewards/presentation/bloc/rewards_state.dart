import '../../../home/domain/entities/member.dart';
import '../models/reward_challenge.dart';

abstract class RewardsState {}

class RewardsInitial extends RewardsState {}

class RewardsLoading extends RewardsState {}

class RewardsSuccess extends RewardsState {
  final Member member;
  final int selectedTab;
  final List<RewardChallenge> challenges;

  RewardsSuccess({
    required this.member,
    required this.selectedTab,
    required this.challenges,
  });

  RewardsSuccess copyWith({
    Member? member,
    int? selectedTab,
    List<RewardChallenge>? challenges,
  }) {
    return RewardsSuccess(
      member: member ?? this.member,
      selectedTab: selectedTab ?? this.selectedTab,
      challenges: challenges ?? this.challenges,
    );
  }
}

class RewardsFailure extends RewardsState {
  final String message;

  RewardsFailure(this.message);
}
