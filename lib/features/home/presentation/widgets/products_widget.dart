import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../core/widgets/app_local_image.dart';
import '../../domain/entities/product.dart';

class ProductWidget extends StatelessWidget {
  final String title;
  final List<Product> products;
  final Map<String, dynamic> size;
  final String? errorMessage;

  const ProductWidget({
    super.key,
    required this.title,
    required this.products,
    required this.size,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.title),
            SectionErrorMessage(message: errorMessage!),
          ],
        ),
      );
    }

    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.title),
            const SectionMessage(message: 'No products available yet.'),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.title),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        SizedBox(
          height: (size['height'] as num).toDouble() + 55,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRouteNames.productDetail,
                    pathParameters: {'id': product.id},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: (size['height'] as num).toDouble(),
                            width: (size['width'] as num).toDouble(),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              child: AppLocalImage(
                                path: product.localImagePath,
                                width: (size['width'] as num).toDouble(),
                                height: (size['height'] as num).toDouble(),
                              ),
                            ),
                          ),

                          if (product.discountPercent != null)
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                ),
                                child: Text(
                                  '${product.discountPercent}% OFF',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        width: (size['width'] as num).toDouble(),
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
