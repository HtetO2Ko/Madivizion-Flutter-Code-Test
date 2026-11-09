import 'dart:async';

import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late final PageController _pageController;

  Timer? _timer;

  int currentIndex = 0;

  final List<String> _banners = [
    'assets/images/banners/1.png',
    'assets/images/banners/2.png',
    'assets/images/banners/3.png',
    'assets/images/banners/4.png',
    'assets/images/banners/5.png',
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.75);

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_pageController.hasClients) return;

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
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: null,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index % _banners.length;
          });
        },
        itemBuilder: (context, index) {
          final bannerIndex = index % _banners.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                _banners[bannerIndex],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
