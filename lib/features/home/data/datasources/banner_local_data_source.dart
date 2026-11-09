import 'package:sqflite/sqflite.dart';

import '../../../../core/database/app_database.dart';
import '../models/banner_model.dart';

class BannerLocalDataSource {
  final AppDatabase appDatabase;

  BannerLocalDataSource(this.appDatabase);

  Future<void> insertBanners(List<BannerModel> banners) async {
    final db = await appDatabase.database;
    final batch = db.batch();

    for (final banner in banners) {
      batch.insert(
        AppDatabase.bannerTable,
        banner.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<BannerModel>> getBanners() async {
    final db = await appDatabase.database;

    final result = await db.query(AppDatabase.bannerTable, orderBy: 'id ASC');

    return result.map(BannerModel.fromMap).toList();
  }

  Future<void> updateLocalImagePath(String bannerId, String imagePath) async {
    final db = await appDatabase.database;

    await db.update(
      AppDatabase.bannerTable,
      {'local_image_path': imagePath},
      where: 'id = ?',
      whereArgs: [bannerId],
    );
  }

  Future<bool> hasBanners() async {
    final db = await appDatabase.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM ${AppDatabase.bannerTable}',
    );

    return (result.first['count'] as int) > 0;
  }
}
