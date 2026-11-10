import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../../features/home/data/datasources/shop_local_data_source.dart';
import '../../features/home/data/models/shop_model.dart';
import '../services/image_downloader.dart';

class ShopSeeder {
  final ShopLocalDataSource localDataSource;
  final ImageDownloader imageDownloader;

  ShopSeeder({required this.localDataSource, required this.imageDownloader});

  Future<void> seedIfNeeded() async {
    final alreadySeeded = await localDataSource.hasShops();

    if (!alreadySeeded) {
      await _insertSeedShops();
    }

    await _downloadMissingImages();
  }

  Future<void> _insertSeedShops() async {
    final jsonString = await rootBundle.loadString('assets/data/shops.json');

    final List<dynamic> jsonList = jsonDecode(jsonString);

    final shops = jsonList.map((json) {
      return ShopModel.fromJson(json as Map<String, dynamic>);
    }).toList();

    await localDataSource.insertShops(shops);
  }

  Future<void> _downloadMissingImages() async {
    final shops = await localDataSource.getShops();

    await Future.wait(
      shops.map((shop) async {
        if (shop.localImagePath != null &&
            shop.localImagePath!.isNotEmpty &&
            await File(shop.localImagePath!).exists()) {
          return;
        }

        try {
          final localPath = await imageDownloader.download(
            id: shop.id,
            imageUrl: shop.imageUrl,
          );
          if (localPath != null) {
            await localDataSource.updateLocalImagePath(
              id: shop.id,
              localImagePath: localPath,
            );
          }
        } catch (_) {
          // Shop details remain available when its image cannot be cached.
        }
      }),
    );
  }
}
