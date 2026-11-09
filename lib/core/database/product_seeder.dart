import 'dart:convert';
import 'package:flutter/services.dart';

import '../services/image_downloader.dart';
import '../../features/home/data/datasources/product_local_data_source.dart';
import '../../features/home/data/models/product_model.dart';

class ProductSeeder {
  final ProductLocalDataSource localDataSource;
  final ImageDownloader imageDownloader;

  ProductSeeder({required this.localDataSource, required this.imageDownloader});

  Future<void> seedIfNeeded() async {
    final alreadySeeded = await localDataSource.hasProducts();

    if (alreadySeeded) return;

    final jsonString = await rootBundle.loadString('assets/data/products.json');

    final List<dynamic> jsonList = jsonDecode(jsonString);

    final products = jsonList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();

    await localDataSource.insertProducts(products);

    downloadMissingImages(products);
  }

  Future<void> downloadMissingImages(List<ProductModel> products) async {
    for (final product in products) {
      if (product.localImagePath != null) continue;

      final imagePath = await imageDownloader.download(
        id: product.id,
        imageUrl: product.imageUrl,
      );

      if (imagePath == null) continue;

      await localDataSource.updateLocalImagePath(product.id, imagePath);
    }
  }
}
