import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../home/domain/repositories/member_repository.dart';
import 'widgets/challenge_card.dart';
import 'widgets/rewards_header.dart';
import 'bloc/rewards_event.dart';
import 'bloc/rewards_state.dart';
import 'bloc/rewards_tab_bloc.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RewardsBloc(memberRepository: getIt<MemberRepository>())
            ..add(RewardsRequested()),
      child: const _RewardsView(),
    );
  }
}

class _RewardsView extends StatelessWidget {
  const _RewardsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsBloc, RewardsState>(
      builder: (context, state) {
        if (state is RewardsInitial || state is RewardsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RewardsFailure) {
          return Center(child: Text(state.message));
        }

        if (state is RewardsSuccess) {
          return Column(
            children: [
              RewardsHeader(
                member: state.member,
                selectedIndex: state.selectedTab,
                onTabChanged: (index) {
                  context.read<RewardsBloc>().add(RewardsTabChanged(index));
                },
              ),
              const SizedBox(height: 30),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: ListView.builder(
                    key: ValueKey(state.selectedTab),
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    itemCount: state.challenges.length,
                    itemBuilder: (context, index) {
                      return ChallengeCard(
                        key: ValueKey(state.challenges[index].id),
                        challenge: state.challenges[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
