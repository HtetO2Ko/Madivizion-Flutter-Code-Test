import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/domain/entities/auth.dart';

class MemberInfo extends StatelessWidget {
  final Auth user;

  const MemberInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final firstName = user.firstName;
    final initial = firstName.isNotEmpty ? firstName[0] : '?';

    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: const Color(0xFF8CC0EB),
          ),
          alignment: Alignment.center,
          child: Text(
            initial,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 13),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.firstName} ${user.lastName}'.trim(),
              style: AppTextStyles.heading,
            ),
            Text('Bronze member', style: AppTextStyles.subheading),
          ],
        ),
      ],
    );
  }
}
