import 'package:flutter/material.dart';

import '../../../../core/widgets/app_local_image.dart';

import '../../../../core/theme/app_colors.dart';

import '../../../home/domain/entities/product.dart';
import 'product_info.dart';
import 'quantity_selector.dart';

class ProductImageCard extends StatelessWidget {
  final Product product;

  const ProductImageCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductInfo(product: product),
                    _buildProductBadge(),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _buildProductImage(),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        const Positioned(bottom: -20, child: QuantitySelector()),
      ],
    );
  }

  Widget _buildProductBadge() {
    if (!product.isNew) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'New',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    final path = product.localImagePath;

    if (path == null || path.isEmpty) {
      return const Center(
        child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
      );
    }

    return AppLocalImage(
      path: path,
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }
}
