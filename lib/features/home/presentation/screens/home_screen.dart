import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../injection_container.dart';
import '../../../../core/database/banner_seeder.dart';
import '../../../../core/database/product_seeder.dart';
import '../../../../core/database/shop_seeder.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/repositories/banner_repository.dart';
import '../../domain/repositories/member_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/shop_repository.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/header/home_header.dart';
import '../widgets/products_widget.dart';
import '../widgets/shops_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => HomeBloc(
      authRepository: getIt<AuthRepository>(),
      bannerRepository: getIt<BannerRepository>(),
      memberRepository: getIt<MemberRepository>(),
      productRepository: getIt<ProductRepository>(),
      shopRepository: getIt<ShopRepository>(),
      productSeeder: getIt<ProductSeeder>(),
      bannerSeeder: getIt<BannerSeeder>(),
      shopSeeder: getIt<ShopSeeder>(),
    )..add(HomeLoadedEvent()),
    child: const _HomeView(),
  );
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  Timer? _connectivityTimer;

  @override
  void initState() {
    super.initState();
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 25),
      (_) {
        if (mounted) {
          context.read<HomeBloc>().add(HomeConnectivityCheckEvent());
        }
      },
    );
  }

  @override
  void dispose() {
    _connectivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.appBackground,
    body: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading || state is HomeInitial) {
          return const HomeLoadingSkeleton();
        }

        if (state is HomeError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined,
                      size: 42, color: AppColors.textSecondary),
                  const SizedBox(height: AppSpacing.md),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () => context.read<HomeBloc>().add(HomeRefreshEvent()),
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is HomeSuccess) {
          final width = MediaQuery.sizeOf(context).width;
          final scale = (width / 390).clamp(0.86, 1.18);
          return Column(
            children: [
              if (state.isRefreshing)
                const LinearProgressIndicator(
                  minHeight: 2,
                  color: AppColors.primary,
                  backgroundColor: AppColors.surfaceMuted,
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(HomeRefreshEvent());
                    await Future<void>.delayed(const Duration(milliseconds: 500));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(
                          user: state.user,
                          member: state.member,
                          banners: state.banners,
                          bannerError: state.bannersError,
                        ),
                        const SizedBox(height: AppSpacing.sectionGap),
                        ProductWidget(
                          title: 'Seasonal specials',
                          products: state.products,
                          size: {'height': 150.0 * scale, 'width': 230.0 * scale},
                          errorMessage: state.productsError,
                        ),
                        const SizedBox(height: AppSpacing.sectionGap),
                        ProductWidget(
                          title: 'Popular 🔥',
                          products: state.products,
                          size: {'height': 250.0 * scale, 'width': 150.0 * scale},
                          errorMessage: state.productsError,
                        ),
                        const SizedBox(height: AppSpacing.sectionGap),
                        ProductWidget(
                          title: 'Order again',
                          products: state.products,
                          size: {'height': 180.0 * scale, 'width': 180.0 * scale},
                          errorMessage: state.productsError,
                        ),
                        const SizedBox(height: AppSpacing.sectionGap),
                        ShopWidget(shops: state.shops, errorMessage: state.shopsError),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const HomeLoadingSkeleton();
      },
    ),
  );
}
