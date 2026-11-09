import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class JDonutApp extends StatelessWidget {
  const JDonutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "J'Donut",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
