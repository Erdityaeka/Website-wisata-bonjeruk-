import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/controller/app_locale_controller.dart';
import 'package:desa_bonjeruk/controller/app_theme_controller.dart';
import 'package:desa_bonjeruk/controller/home_controller.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:desa_bonjeruk/widgets/banner_logo_widget.dart';
import 'package:desa_bonjeruk/widgets/locationwisatawidget.dart';
import 'package:desa_bonjeruk/widgets/medsos_widget.dart';
import 'package:desa_bonjeruk/widgets/welcome_info_widget.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.init(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? putih : hijau;

    return Scaffold(
      backgroundColor: isDark ? hitam : putih,
      appBar: _buildAppbar(l10n, isDark, iconColor),
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BannerLogoWidget(controller: _controller),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
                  top: 5.0,
                  bottom: 20.0,
                ),
                child: Column(
                  children: [
                    _buildDeskripsi(l10n, isDark),
                    const SizedBox(height: 5),
                    WelcomeInfoWidget(controller: _controller),
                    const SizedBox(height: 5),
                    LocationwisataWidget(controller: _controller),
                    const SizedBox(height: 5),
                    MedsosWidget(controller: _controller),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildFooter(l10n, isDark),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(
    AppLocalizations? l10n,
    bool isDark,
    Color iconColor,
  ) {
    return AppBar(
      titleSpacing: 16,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('HI,', style: hitamBold12.copyWith(color: isDark ? putih : hitam)),
              const SizedBox(width: 5),
              Text(
                l10n?.homewelcometitle ?? 'Selamat Datang Wisatawan 🖐️',
                style: hitamBold12.copyWith(color: isDark ? putih : hitam),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            l10n?.homewelcomesubtitle ??
                'Ayo Mulai Mencari Informasi Di Desa Wisata Bonjeruk',
            style: hitamreguler10.copyWith(
              color: isDark ? putih : hitam,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        _buildAppBarCapsuleButton(
          onTap: AppLocaleController.toggleLocale,
          isDark: isDark,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.translate, color: iconColor, size: 16),
              const SizedBox(width: 5),
              Text(
                l10n?.localeName == 'en' ? 'ENG' : 'IND',
                style: hitamBold12.copyWith(color: isDark ? putih : hitam),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        _buildAppBarCapsuleButton(
          onTap: AppThemeController.toggleTheme,
          isDark: isDark,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: iconColor,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                isDark ? 'Terang' : 'Gelap',
                style: hitamBold12.copyWith(color: isDark ? putih : hitam),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(color: isDark ? hitam : putih),
      ),
    );
  }

  Widget _buildAppBarCapsuleButton({
    required VoidCallback onTap,
    required bool isDark,
    required Widget child,
  }) {
    final shadowColor = isDark
        ? putih.withOpacity(0.15)
        : hitam.withOpacity(0.1);

    return Center(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          hoverColor: shadowColor,
          splashColor: shadowColor,
          highlightColor: shadowColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildDeskripsi(AppLocalizations? l10n, bool isDark) {
    final activeTextColor = isDark ? putih : hitam;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          l10n?.homeTitle ?? 'Desa Bonjeruk',
          textAlign: TextAlign.center,
          style: hitamBold20.copyWith(color: activeTextColor),
        ),
        const SizedBox(height: 10),
        Text(
          l10n?.homeDescription ??
              "Bonjeruk’s journey does not end with its declaration as a tourism village...",
          textAlign: TextAlign.center,
          style: hitamreguler12.copyWith(color: activeTextColor),
        ),
      ],
    );
  }

  Widget _buildFooter(AppLocalizations? l10n, bool isDark) {
    final textColor = isDark ? putih : hitam;
    final subTextColor = isDark ? putih.withOpacity(0.7) : hitam.withOpacity(0.7);
    final footerBg = isDark ? hitam : putih;
    final borderColor = isDark ? putih : hitam;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: footerBg,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section Contact Us
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Contact Us',
                    style: hitamBold12.copyWith(color: textColor),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () => _controller.launchURL(
                      'https://maps.app.goo.gl/4UYztaH47Ai1Y9eo6',
                    ),
                    child: Text(
                      
                          'Jl. Pelor Mas Raya No.III, Kekalik Jaya, Kec. Sekarbela, Kota Mataram, Nusa Tenggara Bar. 83126',
                      style: hitamreguler12.copyWith(color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            
            // Section Supported By
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n?.supportedBy ?? 'Didukung Oleh',
                      style: hitamBold12.copyWith(color: textColor),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _controller.launchURL('https://www.instagram.com/kkn_desabonjeruk2026?igsh=MTR6cGJpYXR2OXNydA=='),
                          child: Image.asset(
                            "images/kkn.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'x',
                          style: hitamBold15.copyWith(color: textColor),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: ()=> _controller.launchURL('https://www.instagram.com/desawisatabonjeruk?igsh=NjQ4OXVkMmVnZDh1'),
                          child: Image.asset(
                            "images/desa.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Section Copyright
            Expanded(
              flex: 2,
              child: Text(
                'Copyright © 2026',
                textAlign: TextAlign.end,
                style: hitamreguler12.copyWith(color: subTextColor, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}