import 'package:flutter/material.dart';
import 'package:j_donut/features/welcome/presentation/widgets/welcome_content.dart';

import '../widgets/welcome_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [const WelcomeBackground(), WelcomeContent()],
      ),
    );
  }
}
