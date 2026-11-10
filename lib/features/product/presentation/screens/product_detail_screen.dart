import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../home/domain/repositories/product_repository.dart';
import '../bloc/product_detail/product_detail_bloc.dart';
import '../bloc/product_detail/product_detail_event.dart';
import '../bloc/product_detail/product_detail_state.dart';
import '../bloc/quantity/quantity_bloc.dart';
import '../widgets/product_detail_body.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductDetailBloc(productRepository: getIt<ProductRepository>())
            ..add(ProductDetailRequested(productId)),
      child: const _ProductDetailView(),
    );
  }
}

class _ProductDetailView extends StatelessWidget {
  const _ProductDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  AppSkeleton(height: 300, radius: 20),
                  SizedBox(height: 20),
                  AppSkeleton(height: 24, width: 180),
                  SizedBox(height: 12),
                  AppSkeleton(height: 16),
                  SizedBox(height: 10),
                  AppSkeleton(height: 16, width: 240),
                ],
              ),
            );
          }

          if (state is ProductDetailNotFound) {
            return const Center(child: Text('Product not found.'));
          }

          if (state is ProductDetailError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailSuccess) {
            return BlocProvider(
              create: (_) => QuantityBloc(),
              child: ProductDetailBody(product: state.product),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
