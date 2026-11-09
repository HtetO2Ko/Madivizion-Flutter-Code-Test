import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final int count;

  const NotificationButton({super.key, this.count = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: const BoxDecoration(
        color: Color(0xFFF69D39),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_outlined,
            size: 28,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: const TextStyle(fontSize: 10, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
