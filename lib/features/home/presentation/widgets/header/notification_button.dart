import 'package:flutter/material.dart';
import 'package:j_donut/core/widgets/header_button.dart';

class NotificationButton extends StatelessWidget {
  final int count;

  const NotificationButton({super.key, this.count = 0});

  @override
  Widget build(BuildContext context) {
    return HeaderButton(
      count: count,
      child: Icon(Icons.notifications_outlined, size: 28, color: Colors.white),
    );
  }
}
