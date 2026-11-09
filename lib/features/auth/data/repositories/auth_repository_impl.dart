import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveUser(Auth user) {
    final model = AuthModel(
      phone: user.phone,
      firstName: user.firstName,
      lastName: user.lastName,
      dateOfBirth: user.dateOfBirth,
      createdAt: user.createdAt,
    );

    return localDataSource.saveUser(model);
  }

  @override
  Future<Auth?> getUserByPhone(String phone) {
    return localDataSource.getUserByPhone(phone);
  }
}
