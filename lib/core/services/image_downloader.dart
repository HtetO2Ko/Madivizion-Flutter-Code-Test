import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageDownloader {
  final Dio dio;
  final String folderName;

  ImageDownloader(this.dio, {this.folderName = 'images'});

  Future<String?> download({
    required String id,
    required String imageUrl,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final imageDirectory = Directory(path.join(directory.path, folderName));

      if (!await imageDirectory.exists()) {
        await imageDirectory.create(recursive: true);
      }

      final extension = _getImageExtension(imageUrl);
      final filePath = path.join(imageDirectory.path, '$id$extension');
      final file = File(filePath);

      if (await file.exists() && await file.length() > 0) {
        return filePath;
      }

      await dio.download(
        imageUrl,
        filePath,
        options: Options(
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

      if (await file.exists() && await file.length() > 0) {
        return filePath;
      }

      return null;
    } on DioException {
      return null;
    } on FileSystemException {
      return null;
    }
  }

  String _getImageExtension(String url) {
    final uri = Uri.tryParse(url);
    final extension = path.extension(uri?.path ?? '');

    const allowedExtensions = {'.png', '.jpg', '.jpeg', '.webp'};

    return allowedExtensions.contains(extension.toLowerCase())
        ? extension.toLowerCase()
        : '.jpg';
  }
}
