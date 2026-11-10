abstract class RewardsEvent {}

class RewardsRequested extends RewardsEvent {}

class RewardsTabChanged extends RewardsEvent {
  final int index;

  RewardsTabChanged(this.index);
}
