import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../core/theme/app_spacing.dart';
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
      buildWhen: (previous, current) {
        // The outer widget only handles screen-level state changes.
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        if (state is RewardsInitial || state is RewardsLoading) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                AppSkeleton(height: 100, radius: 20),
                SizedBox(height: AppSpacing.lg),
                AppSkeleton(height: 150, radius: 16),
                SizedBox(height: AppSpacing.md),
                AppSkeleton(height: 150, radius: 16),
              ],
            ),
          );
        }

        if (state is RewardsFailure) {
          return Center(child: Text(state.message));
        }

        if (state is RewardsSuccess) {
          return const _RewardsSuccessView();
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _RewardsSuccessView extends StatelessWidget {
  const _RewardsSuccessView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RewardsBloc, RewardsState>(
          buildWhen: (previous, current) {
            if (previous is! RewardsSuccess || current is! RewardsSuccess) {
              return false;
            }

            return previous.selectedTab != current.selectedTab ||
                previous.member != current.member;
          },
          builder: (context, state) {
            if (state is! RewardsSuccess) {
              return const SizedBox.shrink();
            }

            return RewardsHeader(
              member: state.member,
              selectedIndex: state.selectedTab,
              onTabChanged: (index) {
                context.read<RewardsBloc>().add(RewardsTabChanged(index));
              },
            );
          },
        ),

        const SizedBox(height: 30),

        Expanded(
          child: BlocBuilder<RewardsBloc, RewardsState>(
            buildWhen: (previous, current) {
              if (previous is! RewardsSuccess || current is! RewardsSuccess) {
                return false;
              }

              return previous.selectedTab != current.selectedTab ||
                  previous.challenges != current.challenges;
            },
            builder: (context, state) {
              if (state is! RewardsSuccess) {
                return const SizedBox.shrink();
              }

              if (state.challenges.isEmpty) {
                return const SectionMessage(
                  message: 'No challenges available yet.',
                );
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: ListView.builder(
                  key: ValueKey(state.selectedTab),
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  itemCount: state.challenges.length,
                  itemBuilder: (context, index) {
                    final challenge = state.challenges[index];

                    return ChallengeCard(
                      key: ValueKey(challenge.id),
                      challenge: challenge,
                      index: index,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
