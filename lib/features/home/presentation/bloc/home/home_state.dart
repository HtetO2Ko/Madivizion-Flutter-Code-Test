import '../../../../auth/domain/entities/auth.dart';
import '../../../domain/entities/banner.dart';
import '../../../domain/entities/member.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/shop.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Auth user;
  final Member member;
  final List<Banner> banners;
  final List<Product> products;
  final List<Shop> shops;
  final bool isOffline;
  final bool isRefreshing;
  final String? bannersError;
  final String? productsError;
  final String? shopsError;

  HomeSuccess({
    required this.user,
    required this.member,
    required this.banners,
    required this.products,
    required this.shops,
    this.isOffline = false,
    this.isRefreshing = false,
    this.bannersError,
    this.productsError,
    this.shopsError,
  });

  HomeSuccess copyWith({bool? isOffline, bool? isRefreshing}) => HomeSuccess(
    user: user,
    member: member,
    banners: banners,
    products: products,
    shops: shops,
    isOffline: isOffline ?? this.isOffline,
    isRefreshing: isRefreshing ?? this.isRefreshing,
    bannersError: bannersError,
    productsError: productsError,
    shopsError: shopsError,
  );
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
