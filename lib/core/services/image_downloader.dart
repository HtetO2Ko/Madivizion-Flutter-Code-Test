import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageDownloadException implements Exception {
  const ImageDownloadException(this.message, {this.cause});
  final String message;
  final Object? cause;

  @override
  String toString() => 'ImageDownloadException: $message';
}

class ImageDownloader {
  final Dio dio;
  final String folderName;

  ImageDownloader(this.dio, {this.folderName = 'images'});

  Future<String?> download({
    required String id,
    required String imageUrl,
  }) async {
    String? filePath;
    try {
      final uri = Uri.tryParse(imageUrl);
      if (uri == null || !uri.hasScheme ||
          (uri.scheme != 'http' && uri.scheme != 'https')) {
        throw const ImageDownloadException('Invalid image URL.');
      }

      final directory = await getApplicationDocumentsDirectory();
      final imageDirectory = Directory(path.join(directory.path, folderName));
      await imageDirectory.create(recursive: true);

      final extension = _getImageExtension(imageUrl);
      filePath = path.join(imageDirectory.path, '$id$extension');
      final file = File(filePath);

      if (await file.exists() && await file.length() > 0) return filePath;

      await dio.download(
        imageUrl,
        filePath,
        options: Options(
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          followRedirects: true,
        ),
      );

      if (await file.exists() && await file.length() > 0) return filePath;
      throw const ImageDownloadException('Downloaded image is empty.');
    } on ImageDownloadException {
      await _deletePartialFile(filePath);
      rethrow;
    } on DioException catch (error) {
      await _deletePartialFile(filePath);
      throw ImageDownloadException('Unable to download image.', cause: error);
    } on FileSystemException catch (error) {
      await _deletePartialFile(filePath);
      throw ImageDownloadException('Unable to save image locally.', cause: error);
    } catch (error) {
      await _deletePartialFile(filePath);
      throw ImageDownloadException('Unexpected image download failure.', cause: error);
    }
  }

  Future<void> _deletePartialFile(String? filePath) async {
    if (filePath == null) return;
    try {
      final file = File(filePath);
      if (await file.exists()) await file.delete();
    } on FileSystemException {
      // Preserve the original download exception.
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
