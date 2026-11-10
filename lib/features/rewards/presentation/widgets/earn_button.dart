import 'package:flutter/material.dart';

class EarnButton extends StatefulWidget {
  final bool isCompleted;

  const EarnButton({super.key, required this.isCompleted});

  @override
  State<EarnButton> createState() => _EarnButtonState();
}

class _EarnButtonState extends State<EarnButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _updatePulse();
  }

  void _updatePulse() {
    if (widget.isCompleted) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }

  @override
  void didUpdateWidget(covariant EarnButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isCompleted != widget.isCompleted) {
      _updatePulse();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isCompleted
        ? const Color(0xFF55C9E5)
        : const Color(0xFFE5E5E5);

    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulseScale = widget.isCompleted
            ? 1 + (_pulseController.value * 0.05)
            : 1.0;

        return AnimatedScale(
          scale: _isPressed ? 0.92 * pulseScale : pulseScale,
          duration: const Duration(milliseconds: 120),
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
        },
        child: Container(
          width: 72,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'EARN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
