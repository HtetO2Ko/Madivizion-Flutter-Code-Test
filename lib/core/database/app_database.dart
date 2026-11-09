import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _databaseName = 'j_donut.db';
  static const int _databaseVersion = 1;

  static const String userTable = 'users';
  static const String productTable = 'products';
  static const String bannerTable = 'banners';

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
      },
    );
  }

  Future<void> deleteDatabaseFile() async {
    await _database?.close();
    _database = null;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    await deleteDatabase(path);
  }

  Future<void> deleteAllTables() async {
    final db = await database;

    await db.delete(userTable);
    await db.delete(productTable);
  }
}
