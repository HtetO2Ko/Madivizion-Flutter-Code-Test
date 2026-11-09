import '../entities/auth.dart';

abstract class AuthRepository {
  Future<void> saveUser(Auth auth);

  Future<Auth?> getUserByPhone(String phone);
}
