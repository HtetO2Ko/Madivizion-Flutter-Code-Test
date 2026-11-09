import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _databaseName = 'j_donut.db';
  static const int _databaseVersion = 1;

  static const String userTable = 'users';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $userTable (
            phone TEXT PRIMARY KEY,
            first_name TEXT NOT NULL,
            last_name TEXT,
            date_of_birth TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> deleteDatabaseFile() async {
    debugPrint("Deleting Database");
    await _database?.close();
    _database = null;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    await deleteDatabase(path);
    debugPrint("Deleting Database Done");
  }

  Future<void> deleteAllTables() async {
    final db = await database;

    await db.delete(userTable);
  }
}
