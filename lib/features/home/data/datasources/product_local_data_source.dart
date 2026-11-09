import 'package:sqflite/sqflite.dart';

import '../../../../core/database/app_database.dart';
import '../models/product_model.dart';

class ProductLocalDataSource {
  final AppDatabase appDatabase;

  ProductLocalDataSource(this.appDatabase);

  Future<void> insertProducts(List<ProductModel> products) async {
    final db = await appDatabase.database;

    final batch = db.batch();

    for (final product in products) {
      batch.insert(
        AppDatabase.productTable,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await appDatabase.database;

    final result = await db.query(AppDatabase.productTable, orderBy: 'id ASC');

    return result.map(ProductModel.fromMap).toList();
  }

  Future<void> updateLocalImagePath(String productId, String imagePath) async {
    final db = await appDatabase.database;

    await db.update(
      AppDatabase.productTable,
      {'local_image_path': imagePath},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  Future<bool> hasProducts() async {
    final db = await appDatabase.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM ${AppDatabase.productTable}',
    );

    return (result.first['count'] as int) > 0;
  }
}
