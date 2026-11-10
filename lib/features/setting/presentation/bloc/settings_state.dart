abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLogoutSuccess extends SettingsState {}

class SettingsFailure extends SettingsState {
  final String message;

  SettingsFailure(this.message);
}
