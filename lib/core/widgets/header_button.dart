import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  final int count;
  final Widget child;

  const HeaderButton({super.key, required this.child, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: const BoxDecoration(
        color: Color(0xFFFF781B),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
