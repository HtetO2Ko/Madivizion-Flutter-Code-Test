import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../features/home/data/datasources/banner_local_data_source.dart';
import '../../features/home/data/models/banner_model.dart';
import '../services/image_downloader.dart';

class BannerSeeder {
  final BannerLocalDataSource localDataSource;
  final ImageDownloader imageDownloader;

  BannerSeeder({required this.localDataSource, required this.imageDownloader});

  Future<void> seedIfNeeded() async {
    final alreadySeeded = await localDataSource.hasBanners();
    debugPrint("Banner Check Seeded");

    if (alreadySeeded) {
      await downloadMissingImages(await localDataSource.getBanners());
      return;
    }
    debugPrint("Banner Seeding");

    final jsonString = await rootBundle.loadString('assets/data/banners.json');

    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    final banners = jsonList
        .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
        .toList();

    await localDataSource.insertBanners(banners);
    debugPrint("Banner Seeded");

    await downloadMissingImages(await localDataSource.getBanners());
  }

  Future<void> downloadMissingImages(List<BannerModel> banners) async {
    for (final banner in banners) {
      if (banner.localImagePath != null) {
        final existingFile = File(banner.localImagePath!);

        if (await existingFile.exists()) continue;
      }

      try {
        final imagePath = await imageDownloader.download(
          id: banner.id,
          imageUrl: banner.imageUrl,
        );
        if (imagePath != null) {
          await localDataSource.updateLocalImagePath(banner.id, imagePath);
        }
      } catch (_) {
        // Banner metadata remains available when an image cannot be cached.
      }
    }
  }
}
