import '../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart' hide Banner;

import '../../../../auth/domain/entities/auth.dart';
import '../../../domain/entities/banner.dart';
import '../../../domain/entities/member.dart';
import 'banner_carousel.dart';
import 'member_info.dart';
import 'notification_button.dart';
import 'points_progress_label.dart';

class HomeHeader extends StatelessWidget {
  final Auth user;
  final Member member;
  final List<Banner> banners;
  final String? bannerError;

  const HomeHeader({
    super.key,
    required this.user,
    required this.member,
    required this.banners,
    this.bannerError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.headerBackground,
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
                MemberInfo(user: user, tier: member.tier),
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
          BannerCarousel(banners: banners, errorMessage: bannerError),
        ],
      ),
    );
  }
}
