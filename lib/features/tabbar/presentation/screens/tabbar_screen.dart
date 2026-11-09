import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/tabbar_bloc.dart';
import '../bloc/tabbar_event.dart';
import '../bloc/tabbar_state.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class TabbarScreen extends StatelessWidget {
  const TabbarScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    Center(child: Text('Rewards Screen')),
    Center(child: Text('Order Screen')),
    Center(child: Text('Wallet Screen')),
    Center(child: Text('Settings Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabbarBloc(),
      child: BlocBuilder<TabbarBloc, TabbarState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(index: state.currentIndex, children: _screens),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<TabbarBloc>().add(TabChanged(index));
              },
            ),
          );
        },
      ),
    );
  }
}
