import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/repositories/banner_repository.dart';
import '../../domain/repositories/member_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/header/home_header.dart';
import '../widgets/products_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        authRepository: getIt<AuthRepository>(),
        bannerRepository: getIt<BannerRepository>(),
        memberRepository: getIt<MemberRepository>(),
        productRepository: getIt<ProductRepository>(),
      )..add(HomeLoadedEvent()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }

          if (state is HomeSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(
                    user: state.user,
                    member: state.member,
                    banners: state.banners,
                  ),
                  const SizedBox(height: 20),
                  ProductWidget(
                    title: "Seasonal specials",
                    products: state.products,
                    size: {"height": 150.0, "width": 230.0},
                  ),
                  const SizedBox(height: 20),
                  ProductWidget(
                    title: "Popular 🔥",
                    products: state.products,
                    size: {"height": 250.0, "width": 150.0},
                  ),
                  const SizedBox(height: 20),
                  ProductWidget(
                    title: "Order again",
                    products: state.products,
                    size: {"height": 180.0, "width": 180.0},
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
