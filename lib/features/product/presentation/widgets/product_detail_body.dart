import 'package:flutter/material.dart';

import '../../../home/domain/entities/product.dart';
import 'add_to_cart_button.dart';
import 'product_description.dart';
import 'product_image_card.dart';

class ProductDetailBody extends StatelessWidget {
  final Product product;

  const ProductDetailBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageCard(product: product),
              const SizedBox(height: 40),
              ProductDescription(description: product.description),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            minimum: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
            child: AddToCartButton(product: product),
          ),
        ),
      ],
    );
  }
}
