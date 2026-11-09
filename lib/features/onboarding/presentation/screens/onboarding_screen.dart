import 'package:flutter/material.dart';

import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [OnboardingBackground(), OnboardingContent()],
      ),
    );
  }
}
