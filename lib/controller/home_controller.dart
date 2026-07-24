import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController {
  late PageController pageController;
  Timer? _timer;
  int currentPage = 0;

  final List<String> images = [
    'images/gambar1.jpg',
    'images/gambar2.jpg',
    'images/gambar3.jpg',
    'images/gambar4.jpg',
    'images/gambar5.png',
    'images/gambar6.png',
    'images/gambar7.jpg',
  ];

  void init(void Function() onStateChange) {
    pageController = PageController(initialPage: 0);
    startAutoScroll(onStateChange);
  }

  void startAutoScroll(void Function() onStateChange) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (images.isEmpty) return;

      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }

      onStateChange();
    });
  }

  void onPageChanged(int index, void Function() onStateChange) {
    currentPage = index;
    onStateChange();
    startAutoScroll(onStateChange);
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Tidak dapat membuka URL: $urlString');
      }
    } catch (e) {
      debugPrint('Error saat membuka URL: $e');
    }
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    pageController.dispose();
  }
}
