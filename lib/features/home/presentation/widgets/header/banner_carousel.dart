import 'dart:async';
import 'package:flutter/material.dart' hide Banner;
import '../../../domain/entities/banner.dart';
import 'banner_image.dart';

class BannerCarousel extends StatefulWidget {
  final List<Banner> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late final PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.75);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (widget.banners.length <= 1 || !_pageController.hasClients) {
        return;
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: null,
        itemBuilder: (context, index) {
          final banner = widget.banners[index % widget.banners.length];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BannerImage(banner: banner),
          );
        },
      ),
    );
  }
}
