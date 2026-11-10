import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc({required this.repository}) : super(SettingsInitial()) {
    on<SettingsLogoutRequested>(_onLogout);
  }

  Future<void> _onLogout(
    SettingsLogoutRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    try {
      await repository.logout();

      emit(SettingsLogoutSuccess());
    } catch (error) {
      emit(SettingsFailure('Unable to logout. Please try again.'));
    }
  }
}
