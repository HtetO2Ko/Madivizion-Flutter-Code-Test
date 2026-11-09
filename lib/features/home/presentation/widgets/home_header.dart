import 'package:flutter/material.dart' hide Banner;

import '../../../auth/domain/entities/auth.dart';
import '../../domain/entities/banner.dart';
import '../../domain/entities/member.dart';
import 'banner_carousel.dart';
import 'member_info.dart';
import 'notification_button.dart';
import 'points_progress_label.dart';

class HomeHeader extends StatelessWidget {
  final Auth user;
  final Member member;
  final List<Banner> banners;

  const HomeHeader({
    super.key,
    required this.user,
    required this.member,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFFBFDDF0),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MemberInfo(
                  user: user,
                  // Pass member tier if MemberInfo is updated to accept it.
                ),
                NotificationButton(count: member.notificationCount),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: PointsProgressLabel(
              pointsRemaining: member.pointsToNextTier,
              nextTier: member.nextTier,
            ),
          ),
          const SizedBox(height: 20),
          BannerCarousel(banners: banners),
        ],
      ),
    );
  }
}
