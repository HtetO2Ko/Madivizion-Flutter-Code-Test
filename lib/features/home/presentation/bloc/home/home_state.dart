import '../../../../auth/domain/entities/auth.dart';
import '../../../domain/entities/banner.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Auth user;
  final List<Banner> banners;

  HomeSuccess({required this.user, required this.banners});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
