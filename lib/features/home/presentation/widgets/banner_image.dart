import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Banner;

import '../../domain/entities/banner.dart';
import 'banner_placeholder.dart';

class BannerImage extends StatelessWidget {
  final Banner banner;

  const BannerImage({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    final localPath = banner.localImagePath;

    if (localPath != null && localPath.isNotEmpty) {
      return Image.file(
        File(localPath),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _assetImage(),
      );
    }

    if (banner.imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: banner.imageUrl,
        cacheKey: banner.id,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, __) => _loadingPlaceholder(),
        errorWidget: (_, __, ___) => _assetImage(),
      );
    }

    return _assetImage();
  }

  Widget _assetImage() {
    return const BannerPlaceholder();
  }

  Widget _loadingPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
