// hero_banner_carousel.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanae_app/ui/widgets/home_widgets/hero_banner.dart';

class HeroBannerCarousel extends StatefulWidget {
  final List<ImageProvider> images;
  final double height;
  final Duration autoPlayInterval;
  final void Function(int index)? onBuy; // ضغط زر الشراء لكل بنر

  const HeroBannerCarousel({
    super.key,
    required this.images,
    this.height = 96,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.onBuy,
  });

  @override
  State<HeroBannerCarousel> createState() => _HeroBannerCarouselState();
}

class _HeroBannerCarouselState extends State<HeroBannerCarousel> {
  late final PageController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller =
        PageController(viewportFraction: 0.86); // يخلي الجيران ظاهرين شوي
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted || widget.images.isEmpty) return;
      final next = (_controller.page ?? 0).round() + 1;
      _controller.animateToPage(
        next % widget.images.length,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        padEnds: false,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // تأثير خفيف (scale + opacity) للجيران
              double value = 1.0;
              if (_controller.position.haveDimensions) {
                final currentPage =
                    (_controller.page ?? _controller.initialPage).toDouble();
                value = (index - currentPage).abs();

                value = (1 - (value * 0.08)).clamp(0.90, 1.0);
              }
              return Center(
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: Padding(
              // فراغ بسيط بين العناصر
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: HeroBanner(
                productImage: widget.images[index],
                height: widget.height,
                onBuy: widget.onBuy == null ? null : () => widget.onBuy!(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
