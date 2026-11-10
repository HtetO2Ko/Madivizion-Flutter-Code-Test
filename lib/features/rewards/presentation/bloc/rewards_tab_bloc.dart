import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/repositories/member_repository.dart';
import '../data/rewards_static_data.dart';
import 'rewards_event.dart';
import 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  final MemberRepository memberRepository;

  RewardsBloc({required this.memberRepository}) : super(RewardsInitial()) {
    on<RewardsRequested>(_onRewardsRequested);
    on<RewardsTabChanged>(_onTabChanged);
  }

  Future<void> _onRewardsRequested(
    RewardsRequested event,
    Emitter<RewardsState> emit,
  ) async {
    emit(RewardsLoading());

    try {
      final member = await memberRepository.getMember();

      if (member == null) {
        emit(RewardsFailure('Member information not found.'));
        return;
      }

      emit(
        RewardsSuccess(
          member: member,
          selectedTab: 0,
          challenges: RewardsStaticData.challenges,
        ),
      );
    } catch (error) {
      emit(RewardsFailure('Unable to load rewards.'));
    }
  }

  void _onTabChanged(RewardsTabChanged event, Emitter<RewardsState> emit) {
    final currentState = state;

    if (currentState is! RewardsSuccess) return;
    if (event.index < 0 || event.index > 1) return;
    if (currentState.selectedTab == event.index) return;

    emit(
      currentState.copyWith(
        selectedTab: event.index,
        challenges: event.index == 0
            ? RewardsStaticData.challenges
            : RewardsStaticData.gifts,
      ),
    );
  }
}
