import '../../../../core/database/app_database.dart';
import '../../../../core/storage/session_storage.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final AppDatabase appDatabase;

  SettingsRepositoryImpl({required this.appDatabase});

  @override
  Future<void> logout() async {
    await SessionStorage.clearSession();
  }
}
