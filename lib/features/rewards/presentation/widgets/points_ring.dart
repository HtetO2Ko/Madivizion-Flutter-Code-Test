import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

import '../../../home/domain/entities/member.dart';

class PointsRing extends StatelessWidget {
  final Member member;

  const PointsRing({super.key, required this.member});

  static const int totalPoints = 680000;

  double get pointsProgress {
    if (totalPoints <= 0) return 0;

    return (member.points / totalPoints).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: pointsProgress),
      duration: const Duration(milliseconds: 1600),
      curve: Curves.easeOutCubic,
      builder: (context, animatedProgress, child) {
        return AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size.infinite,
                painter: _PointsRingPainter(animatedProgress),
              ),

              Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total points',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatPoints(totalPoints),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPoints(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (match) => '${match[1]},',
    );
  }
}

class _PointsRingPainter extends CustomPainter {
  final double progress;

  _PointsRingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = math.min(size.width, size.height) / 2 - 9;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = const Color(0xFFEEF0F1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    final progressPaint = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (progress > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PointsRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
