import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/session_storage.dart';
import '../../../../auth/domain/entities/auth.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';
import '../../../domain/entities/banner.dart';
import '../../../domain/repositories/banner_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository authRepository;
  final BannerRepository bannerRepository;

  HomeBloc({required this.authRepository, required this.bannerRepository})
    : super(HomeInitial()) {
    on<HomeLoadedEvent>(_onHomeLoaded);
  }

  Future<void> _onHomeLoaded(
    HomeLoadedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
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

      final List<Banner> banners = await bannerRepository.getBanners();

      emit(HomeSuccess(user: user, banners: banners));
    } catch (error) {
      emit(HomeError('Unable to load home information.'));
    }
  }
}
