import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../core/widgets/app_local_image.dart';
import '../../domain/entities/shop.dart';

class ShopWidget extends StatelessWidget {
  final List<Shop> shops;
  final String? errorMessage;
  const ShopWidget({super.key, required this.shops, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SectionErrorMessage(message: errorMessage!),
      );
    }

    if (shops.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: SectionMessage(
          message: 'No nearby shops are available right now.',
          icon: Icons.storefront_outlined,
        ),
      );
    }

    return Stack(
      children: [
        Image.asset(
          "assets/images/shop.png",
          height: 460,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "There are ${shops.length} J'Donut shops\nnear you.",
                style: AppTextStyles.title.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.lg),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Text(
                    "EXPLORE NOW",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.info,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 270,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops.length,
                  itemBuilder: (context, index) {
                    final shop = shops[index];
                    return Container(
                      width: 250,
                      margin: const EdgeInsets.only(right: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AppLocalImage(
                              path: shop.localImagePath,
                              height: 150,
                              width: double.infinity,
                              fallbackIcon: Icons.store,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            shop.name,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            shop.address,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 196, 196, 196),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Order Online',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
