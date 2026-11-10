import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorageException implements Exception {
  const SessionStorageException(this.operation, this.cause);
  final String operation;
  final Object cause;

  @override
  String toString() => 'Session storage failed during $operation.';
}

class SessionStorage {
  SessionStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _phoneKey = 'session_phone_number';

  static Future<void> savePhoneNumber(String phoneNumber) async {
    try {
      await _storage.write(key: _phoneKey, value: phoneNumber);
    } catch (error) {
      throw SessionStorageException('save', error);
    }
  }

  static Future<String?> getPhoneNumber() async {
    try {
      return await _storage.read(key: _phoneKey);
    } catch (error) {
      throw SessionStorageException('read', error);
    }
  }

  static Future<void> clearSession() async {
    try {
      await _storage.delete(key: _phoneKey);
    } catch (error) {
      throw SessionStorageException('clear', error);
    }
  }
}
