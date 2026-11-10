import 'package:flutter/material.dart';

enum BadgeType { bronze, gold, platinum }

class ShieldBadge extends StatelessWidget {
  final BadgeType type;

  const ShieldBadge({super.key, required this.type});

  List<Color> get colors {
    switch (type) {
      case BadgeType.gold:
        return const [Color(0xFFFFE082), Color(0xFFFFB300), Color(0xFFB8860B)];

      case BadgeType.bronze:
        return const [Color(0xFFFFFFFF), Color(0xFFBDBDBD), Color(0xFF757575)];

      case BadgeType.platinum:
        return const [Color(0xFFB3E5FC), Color(0xFF42A5F5), Color(0xFF1565C0)];
    }
  }

  Color get textColor {
    switch (type) {
      case BadgeType.gold:
        return const Color(0xFF704600);
      case BadgeType.bronze:
        return const Color(0xFF424242);
      case BadgeType.platinum:
        return const Color(0xFF0D47A1);
    }
  }

  String get title {
    switch (type) {
      case BadgeType.bronze:
        return 'B';
      case BadgeType.gold:
        return 'G';
      case BadgeType.platinum:
        return 'P';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: ShieldClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 8, color: Colors.white),
                    SizedBox(width: 1),
                    Icon(Icons.star, size: 8, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Shield shape
class ShieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.6);

    path.quadraticBezierTo(size.width / 2, size.height, 0, size.height * 0.6);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
