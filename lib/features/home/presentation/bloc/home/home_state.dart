import '../../../../auth/domain/entities/auth.dart';
import '../../../domain/entities/banner.dart';
import '../../../domain/entities/member.dart';
import '../../../domain/entities/product.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Auth user;
  final Member member;
  final List<Banner> banners;
  final List<Product> products;

  HomeSuccess({
    required this.user,
    required this.member,
    required this.banners,
    required this.products,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
