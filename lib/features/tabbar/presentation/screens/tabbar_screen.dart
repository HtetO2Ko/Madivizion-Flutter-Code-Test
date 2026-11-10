import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_donut/features/rewards/presentation/rewards_screen.dart';

import '../../../setting/presentation/settings_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/tabbar_bloc.dart';
import '../bloc/tabbar_event.dart';
import '../bloc/tabbar_state.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class TabbarScreen extends StatelessWidget {
  const TabbarScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    RewardsScreen(),
    Center(child: Text('Order Screen')),
    Center(child: Text('Wallet Screen')),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabbarBloc(),
      child: BlocBuilder<TabbarBloc, TabbarState>(
        builder: (context, state) {
          return Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.04, 0.0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey<int>(state.currentIndex),
                child: _screens[state.currentIndex],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                if (index != state.currentIndex) {
                  context.read<TabbarBloc>().add(TabChanged(index));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
