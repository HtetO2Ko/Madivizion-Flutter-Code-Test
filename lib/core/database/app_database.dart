import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseStorageException implements Exception {
  const DatabaseStorageException(this.operation, this.cause);
  final String operation;
  final Object cause;

  @override
  String toString() => 'Local database failed during $operation.';
}

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _databaseName = 'j_donut.db';
  static const int _databaseVersion = 3;

  static const String userTable = 'users';
  static const String productTable = 'products';
  static const String bannerTable = 'banners';
  static const String memberTable = 'members';
  static const String shopTable = 'shops';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await _initDatabase();
      return _database!;
    } catch (error) {
      throw DatabaseStorageException('open', error);
    }
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

        await db.execute('''
    CREATE TABLE $productTable (
      id TEXT PRIMARY KEY,
      code TEXT NOT NULL,
      name TEXT NOT NULL,
      price_mmk INTEGER NOT NULL,
      is_new INTEGER NOT NULL DEFAULT 0,
      discount_percent INTEGER,
      image_url TEXT NOT NULL,
      local_image_path TEXT,
      description TEXT NOT NULL
    )
  ''');

        await db.execute('''
    CREATE TABLE $bannerTable (
      id TEXT PRIMARY KEY,
      image_url TEXT NOT NULL,
      local_image_path TEXT
    )
  ''');

        await db.execute('''
    CREATE TABLE $memberTable (
      id INTEGER PRIMARY KEY,
      tier TEXT NOT NULL,
      points INTEGER NOT NULL,
      next_tier TEXT NOT NULL,
      points_to_next_tier INTEGER NOT NULL,
      notification_count INTEGER NOT NULL
    )
  ''');

        await db.execute('''
    CREATE TABLE $shopTable (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      address TEXT NOT NULL,
      image_url TEXT NOT NULL,
      local_image_path TEXT
    )
  ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS $memberTable (
        id INTEGER PRIMARY KEY,
        tier TEXT NOT NULL,
        points INTEGER NOT NULL,
        next_tier TEXT NOT NULL,
        points_to_next_tier INTEGER NOT NULL,
        notification_count INTEGER NOT NULL
      )
    ''');
        }

        if (oldVersion < 3) {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS $shopTable (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        image_url TEXT NOT NULL,
        local_image_path TEXT
      )
    ''');
        }
      },
    );
  }

  Future<void> deleteDatabaseFile() async {
    await _database?.close();
    _database = null;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    try {
      debugPrint("Deleting Database");
      await deleteDatabase(path);
      debugPrint("Deleted Database Successfully");
    } catch (error) {
      throw DatabaseStorageException('delete', error);
    }
  }

  Future<void> deleteAllTables() async {
    final db = await database;

    debugPrint("Deleting Tables");
    await db.delete(userTable);
    await db.delete(productTable);
    await db.delete(bannerTable);
    await db.delete(memberTable);
    await db.delete(shopTable);
    debugPrint("Deleted Tables");
  }
}
