import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/controller/app_locale_controller.dart';
import 'package:desa_bonjeruk/controller/app_theme_controller.dart';
import 'package:desa_bonjeruk/controller/home_controller.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:desa_bonjeruk/widgets/banner_logo_widget.dart';
import 'package:desa_bonjeruk/widgets/medsos_widget.dart';
import 'package:desa_bonjeruk/widgets/welcome_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // Helper dialog konfirmasi sebelum unduh APK
  Future<void> _confirmAndDownloadApk(BuildContext context, bool isDark) async {
    final shouldDownload = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: isDark ? hitam : putih,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Unduh Aplikasi',
            style: hitamBold20.copyWith(color: isDark ? putih : hitam),
          ),
          content: Text(
            'Apakah Anda yakin ingin mengunduh aplikasi informasi Desa Wisata Bonjeruk (APK)?',
            style: hitamreguler12.copyWith(color: isDark ? putih : hitam),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Batal',
                style: hitamreguler12.copyWith(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: hijau,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text('Unduh', style: hitamBold12.copyWith(color: putih)),
            ),
          ],
        );
      },
    );

    if (shouldDownload == true) {
      const directDownloadUrl =
          'https://drive.google.com/file/d/1hQQW_iSsLMjUIKSNhVPtCpmNYX-30IWr/view?usp=sharing';
      final uri = Uri.parse(directDownloadUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Tidak dapat membuka link download APK');
      }
    }
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

                    // Widget Welcome & Info Kontak
                    WelcomeInfoWidget(controller: _controller),
                    const SizedBox(height: 5),

                    // Widget Media Sosial
                    MedsosWidget(controller: _controller),
                  ],
                ),
              ),
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
        const SizedBox(width: 6),
        _buildAppBarCapsuleButton(
          onTap: () => _confirmAndDownloadApk(context, isDark),
          isDark: isDark,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.download, color: iconColor, size: 16),
              const SizedBox(width: 5),
              Text(
                'App',
                style: hitamBold12.copyWith(color: isDark ? putih : hitam),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(color: isDark ? hitam : putih),
      ),
    );
  }

  // Helper Widget
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
              "Bonjeruk’s journey does not end with its declaration as a tourism village — it continues to evolve, guided by a deep commitment to sustainability and the dreams of its ancestors. The people of Bonjeruk believe that a truly beautiful village is one that is clean in its environment, rich in its culture, independent in its economy, and strong in its identity.",
          textAlign: TextAlign.center,
          style: hitamreguler12.copyWith(color: activeTextColor),
        ),
      ],
    );
  }
}
