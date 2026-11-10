import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

import '../models/reward_challenge.dart';

class ChallengeProgressArt extends StatelessWidget {
  final ChallengeType type;
  final int progress;
  final int target;

  const ChallengeProgressArt({
    super.key,
    required this.type,
    required this.progress,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    final value = target <= 0 ? 0.0 : (progress / target).clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: _ChallengePainter(
                type: type,
                progress: animatedProgress,
              ),
            ),

            if (type == ChallengeType.coffee)
              FractionallySizedBox(
                widthFactor: 0.48,
                heightFactor: 0.48,
                child: Image.asset(
                  'assets/images/rewards/coffee.png',
                  fit: BoxFit.contain,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ChallengePainter extends CustomPainter {
  final ChallengeType type;
  final double progress;

  const _ChallengePainter({required this.type, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (type == ChallengeType.donut) {
      _drawDonut(canvas, size);
    } else {
      _drawCoffee(canvas, size);
    }
  }

  void _drawDonut(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.32;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Uncompleted donut.
    final backgroundPaint = Paint()
      ..color = const Color(0xFFE6E6E6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 23;

    // Completed donut.
    final progressPaint = Paint()
      ..color = const Color(0xFFFF83B8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 23
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Each quarter represents one completed challenge.
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );

    // Sprinkles on the completed portion.
    const sprinkleColors = [
      Color(0xFFFFD95A),
      AppColors.primary,
      AppColors.secondary,
      Colors.white,
    ];

    for (int i = 0; i < 24; i++) {
      final fraction = i / 24;

      if (fraction > progress) continue;

      final angle = -math.pi / 2 + fraction * 2 * math.pi;

      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final sprinklePaint = Paint()
        ..color = sprinkleColors[i % sprinkleColors.length]
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(point, point + const Offset(3, -3), sprinklePaint);
    }

    // Donut hole.
    canvas.drawCircle(center, radius - 12, Paint()..color = Colors.white);
  }

  void _drawCoffee(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.42;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = const Color(0xFFECEFF0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi * 0.75, math.pi * 1.5, false, backgroundPaint);

    canvas.drawArc(
      rect,
      math.pi * 0.75,
      math.pi * 1.5 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ChallengePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.type != type;
  }
}
