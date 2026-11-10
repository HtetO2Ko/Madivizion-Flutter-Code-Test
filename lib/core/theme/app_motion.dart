import 'package:flutter/material.dart';

class AppMotion {
  AppMotion._();

  static const Duration fast = Duration(milliseconds: 160);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration slow = Duration(milliseconds: 360);

  static Duration duration(BuildContext context, Duration requested) {
    return MediaQuery.maybeOf(context)?.disableAnimations == true
        ? Duration.zero
        : requested;
  }
}
