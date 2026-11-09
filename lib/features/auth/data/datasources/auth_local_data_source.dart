
import 'package:sqflite/sqflite.dart';
import '../../../../../core/database/app_database.dart';
import '../models/auth_model.dart';

class AuthLocalDataSource {
  final AppDatabase appDatabase;

  AuthLocalDataSource(this.appDatabase);

  Future<void> saveUser(AuthModel user) async {
    final db = await appDatabase.database;

    await db.insert(
      AppDatabase.userTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<AuthModel?> getUserByPhone(String phone) async {
    final db = await appDatabase.database;

    final result = await db.query(
      AppDatabase.userTable,
      where: 'phone = ?',
      whereArgs: [phone],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return AuthModel.fromMap(result.first);
  }
}
