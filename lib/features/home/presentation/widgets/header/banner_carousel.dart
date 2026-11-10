import 'dart:async';

import 'package:flutter/material.dart' hide Banner;

import '../../../domain/entities/banner.dart';
import 'banner_image.dart';

class BannerCarousel extends StatefulWidget {
  final List<Banner> banners;
  final String? errorMessage;

  const BannerCarousel({super.key, required this.banners, this.errorMessage});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel>
    with WidgetsBindingObserver {
  static const _slideInterval = Duration(seconds: 4);
  static const _animationDuration = Duration(milliseconds: 450);

  late final PageController _pageController;

  Timer? _timer;
  int _currentPage = 0;
  bool _isAnimating = false;
  bool _isAppActive = true;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.85);
    WidgetsBinding.instance.addObserver(this);

    _scheduleNextSlide();
  }

  @override
  void didUpdateWidget(covariant BannerCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.banners.length != widget.banners.length) {
      _timer?.cancel();
      _currentPage = 0;

      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }

      _scheduleNextSlide();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isAppActive = state == AppLifecycleState.resumed;

    if (_isAppActive) {
      _scheduleNextSlide();
    } else {
      _timer?.cancel();
    }
  }

  void _scheduleNextSlide() {
    _timer?.cancel();

    if (!_isAppActive || widget.banners.length <= 1) {
      return;
    }

    _timer = Timer(_slideInterval, _goToNextPage);
  }

  Future<void> _goToNextPage() async {
    if (!mounted ||
        !_isAppActive ||
        _isAnimating ||
        !_pageController.hasClients ||
        widget.banners.length <= 1) {
      _scheduleNextSlide();
      return;
    }

    _isAnimating = true;

    try {
      final nextPage = (_currentPage + 1) % widget.banners.length;

      await _pageController.animateToPage(
        nextPage,
        duration: _animationDuration,
        curve: Curves.easeOutCubic,
      );

      _currentPage = nextPage;
    } finally {
      _isAnimating = false;

      if (mounted) {
        _scheduleNextSlide();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text(
            widget.errorMessage ?? 'Promotions will appear here.',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.banners.length,
        onPageChanged: (index) {
          _currentPage = index;
        },
        itemBuilder: (context, index) {
          final banner = widget.banners[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RepaintBoundary(child: BannerImage(banner: banner)),
          );
        },
      ),
    );
  }
}
