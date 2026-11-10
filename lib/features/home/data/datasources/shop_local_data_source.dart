import 'package:sqflite/sqflite.dart';

import '../../../../core/database/app_database.dart';
import '../models/shop_model.dart';

class ShopLocalDataSource {
  final AppDatabase appDatabase;

  ShopLocalDataSource(this.appDatabase);

  Future<List<ShopModel>> getShops() async {
    final db = await appDatabase.database;

    final result = await db.query(AppDatabase.shopTable, orderBy: 'name ASC');

    return result.map(ShopModel.fromMap).toList();
  }

  Future<void> insertShops(List<ShopModel> shops) async {
    final db = await appDatabase.database;
    final batch = db.batch();

    for (final shop in shops) {
      batch.insert(
        AppDatabase.shopTable,
        shop.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> updateLocalImagePath({
    required String id,
    required String localImagePath,
  }) async {
    final db = await appDatabase.database;

    await db.update(
      AppDatabase.shopTable,
      {'local_image_path': localImagePath},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> hasShops() async {
    final db = await appDatabase.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM ${AppDatabase.shopTable}',
    );

    return (result.first['count'] as int) > 0;
  }
}
