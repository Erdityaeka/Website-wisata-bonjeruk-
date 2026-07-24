import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/controller/home_controller.dart';
import 'package:flutter/material.dart';

class BannerLogoWidget extends StatelessWidget {
  final HomeController controller;

  const BannerLogoWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [_buildAutoScrollBanner(), _buildLogo()],
    );
  }

  Widget _buildAutoScrollBanner() {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.onPageChanged(index, () {});
        },
        itemCount: controller.images.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: hitam,
              image: DecorationImage(
                image: AssetImage(controller.images[index]),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Positioned(
      bottom: -50,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: putih,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: hitam.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Image.asset('images/desa.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
