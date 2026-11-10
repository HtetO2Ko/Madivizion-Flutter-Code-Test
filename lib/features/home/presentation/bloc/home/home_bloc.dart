import 'dart:io';

import '../../../../../core/database/banner_seeder.dart';
import '../../../../../core/database/product_seeder.dart';
import '../../../../../core/database/shop_seeder.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/session_storage.dart';
import '../../../../auth/domain/entities/auth.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';
import '../../../domain/repositories/banner_repository.dart';
import '../../../domain/repositories/member_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/repositories/shop_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository authRepository;
  final ProductRepository productRepository;
  final ShopRepository shopRepository;
  final BannerRepository bannerRepository;
  final MemberRepository memberRepository;
  final ProductSeeder productSeeder;
  final BannerSeeder bannerSeeder;
  final ShopSeeder shopSeeder;

  HomeBloc({
    required this.authRepository,
    required this.productRepository,
    required this.shopRepository,
    required this.bannerRepository,
    required this.memberRepository,
    required this.productSeeder,
    required this.bannerSeeder,
    required this.shopSeeder,
  }) : super(HomeInitial()) {
    on<HomeLoadedEvent>((event, emit) => _loadHome(emit));
    on<HomeRefreshEvent>((event, emit) => _loadHome(emit, background: true));
    on<HomeConnectivityCheckEvent>(_onConnectivityCheck);
  }

  Future<void> _onConnectivityCheck(
    HomeConnectivityCheckEvent event,
    Emitter<HomeState> emit,
  ) async {
    final online = await _hasInternet();
    final current = state;
    if (current is HomeSuccess) {
      if (current.isOffline && online) {
        await _loadHome(emit, background: true);
      } else if (current.isOffline == online) {
        emit(current.copyWith(isOffline: !online));
      }
    }
  }

  Future<_SectionResult<T>> _loadSection<T>(
    Future<T> Function() loader,
  ) async {
    try {
      return _SectionResult<T>(data: await loader());
    } catch (_) {
      return _SectionResult<T>(error: 'This section could not be loaded.');
    }
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _loadHome(
    Emitter<HomeState> emit, {
    bool background = false,
  }) async {
    final previous = state;
    if (!background || previous is! HomeSuccess) {
      emit(HomeLoading());
    } else {
      emit(previous.copyWith(isRefreshing: true));
    }

    try {
      final online = await _hasInternet();
      if (online && background) {
        // Retry cached image downloads after connectivity is restored.
        await Future.wait([
          productSeeder.seedIfNeeded(),
          bannerSeeder.seedIfNeeded(),
          shopSeeder.seedIfNeeded(),
        ].map((task) async {
          try {
            await task;
          } catch (_) {
            // A failed image refresh must not hide locally saved content.
          }
        }));
      }
      final phoneNumber = await SessionStorage.getPhoneNumber();

      if (phoneNumber == null || phoneNumber.isEmpty) {
        emit(HomeError('No active user session.'));
        return;
      }

      final Auth? user = await authRepository.getUserByPhone(phoneNumber);
      if (user == null) {
        emit(HomeError('User not found.'));
        return;
      }

      final member = await memberRepository.getMember();
      if (member == null) {
        emit(HomeError('Member information not found.'));
        return;
      }

      final bannersResult = await _loadSection(() => bannerRepository.getBanners());
      final productsResult = await _loadSection(() => productRepository.getProducts());
      final shopsResult = await _loadSection(() => shopRepository.getShops());

      emit(HomeSuccess(
        user: user,
        member: member,
        banners: bannersResult.data ?? const [],
        products: productsResult.data ?? const [],
        shops: shopsResult.data ?? const [],
        isOffline: !online,
        bannersError: bannersResult.error,
        productsError: productsResult.error,
        shopsError: shopsResult.error,
      ));
    } catch (_) {
      if (background && previous is HomeSuccess) {
        emit(previous.copyWith(isRefreshing: false));
      } else {
        emit(HomeError('Unable to load home information. Please try again.'));
      }
    }
  }
}

class _SectionResult<T> {
  const _SectionResult({this.data, this.error});
  final T? data;
  final String? error;
}
