import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorage {
  SessionStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _phoneKey = 'session_phone_number';

  static Future<void> savePhoneNumber(String phoneNumber) async {
    await _storage.write(key: _phoneKey, value: phoneNumber);
  }

  static Future<String?> getPhoneNumber() async {
    return _storage.read(key: _phoneKey);
  }

  static Future<void> clearSession() async {
    await _storage.delete(key: _phoneKey);
  }
}
