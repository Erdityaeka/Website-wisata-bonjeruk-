import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/model/place.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';

class DetailScreen extends StatefulWidget {
  final Place place;
  const DetailScreen({super.key, required this.place});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Fungsi untuk membuka link Google Maps
  Future<void> _openMap(String? linkUrl) async {
    final l10n = AppLocalizations.of(context);

    if (linkUrl == null || linkUrl.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n?.mapUrlNotAvailable ?? 'Tautan peta tidak tersedia',
            ),
          ),
        );
      }
      return;
    }

    final url = Uri.parse(linkUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n?.cannotOpenMapUrl ?? 'Tidak dapat membuka tautan Peta',
            ),
          ),
        );
      }
    }
  }

  // Helper Translasi Deskripsi Hari Buka
  String _getTranslatedHariBuka(String? originalText, bool isEnglish) {
    if (originalText == null || originalText.trim().isEmpty) return '';
    if (!isEnglish) return originalText.trim();

    String text = originalText.trim();
    if (text.toLowerCase().contains('setiap hari')) {
      return text.replaceAll(
        RegExp(r'Setiap hari', caseSensitive: false),
        'Everyday',
      );
    }
    return text;
  }

  // Helper Translasi Deskripsi Pengecualian Hari Buka
  String _getTranslatedKecualiHari(String? originalText, bool isEnglish) {
    if (originalText == null || originalText.trim().isEmpty) return '';
    if (!isEnglish) return originalText.trim();

    String text = originalText.trim();
    if (text.toLowerCase().contains('kecuali hari jumat tutup')) {
      return 'Except Friday (Closed)';
    } else if (text.toLowerCase().contains('kecuali')) {
      return text.replaceAll(
        RegExp(r'Kecuali', caseSensitive: false),
        'Except',
      );
    }
    return text;
  }

  // Fungsi untuk menampilkan Preview Foto dengan Galeri Slide/Swipe & Tombol Navigasi
  void _showImagePreview(BuildContext context, int initialIndex) {
    final List<String> images = widget.place.imageUrls;
    if (images.isEmpty) return;

    final PageController pageController = PageController(
      initialPage: initialIndex,
    );
    int currentIndex = initialIndex;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: putih.withValues(alpha: 0.0),
              insetPadding: const EdgeInsets.all(12),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Slide View Gambar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 450,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: images.length,
                          onPageChanged: (index) {
                            setDialogState(() {
                              currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return InteractiveViewer(
                              panEnabled: true,
                              minScale: 0.5,
                              maxScale: 4,
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      color: putih,
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: hitam.withValues(alpha: 0.4),
                                      ),
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Tombol Kiri (Sebelumnya)
                    if (currentIndex > 0)
                      Positioned(
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: hitam.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: putih,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                    // Tombol Kanan (Selanjutnya)
                    if (currentIndex < images.length - 1)
                      Positioned(
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: hitam.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: putih,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                    // Indikator Posisi Foto
                    Positioned(
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: hitam.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${currentIndex + 1} / ${images.length}',
                          style: TextStyle(
                            color: putih,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Tombol Tutup
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: hitam.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, color: putih, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final dynamicBg = isDark ? hitam : putih;
    final cardBgColor = isDark ? putih : hitam;
    final textColor = isDark ? hitam : putih;
    final subTextColor = isDark ? hitam : putih;

    return Scaffold(
      backgroundColor: dynamicBg,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    _buildHeaderImage(widget.place.imageAsset),
                    _buildTopButtons(context),
                    _buildCardContent(
                      cardBgColor,
                      textColor,
                      subTextColor,
                      isDark,
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomActionBar(cardBgColor, textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(String imageAsset) {
    return Center(
      child: Image.asset(
        imageAsset,
        width: double.infinity,
        height: 380,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 380,
          color: hitam.withValues(alpha: 0.15),
          child: Center(
            child: Icon(
              Icons.broken_image,
              size: 50,
              color: hitam.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.maybePop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(
    Color cardBgColor,
    Color textColor,
    Color subTextColor,
    bool isDark,
  ) {
    final l10n = AppLocalizations.of(context);
    final String currentLang = Localizations.localeOf(context).languageCode;
    final bool isEnglish = currentLang == 'en';

    // Jam Buka Utama
    final String rawJamBuka = widget.place.jamBuka?.trim() ?? '';
    final String displayJamBuka = rawJamBuka.isNotEmpty
        ? rawJamBuka
        : (l10n?.openHours ?? 'Jam buka tidak tersedia');

    // Kiri: Deskripsi Setiap Hari / Buka
    final String rawHariBuka = widget.place.descriptionjamBuka;
    final String displayHariBuka = _getTranslatedHariBuka(
      rawHariBuka,
      isEnglish,
    );

    // Kanan: Deskripsi Kecuali Hari
    final String rawKecualiHari = widget.place.descriptionkecualijamBuka;
    final String displayKecualiHari = _getTranslatedKecualiHari(
      rawKecualiHari,
      isEnglish,
    );

    // Deskripsi tempat sesuai bahasa yang aktif
    final String descriptionText = isEnglish
        ? (widget.place.descriptioninggris.isNotEmpty
              ? widget.place.descriptioninggris
              : widget.place.descriptionindonesia)
        : widget.place.descriptionindonesia;

    return Container(
      margin: const EdgeInsets.only(top: 320),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: hitam.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Nama & Lokasi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.place.name,
                style: hitamBold20.copyWith(color: textColor),
              ),
              const SizedBox(height: 8),

              // Baris Lokasi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: textColor, size: 16),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.place.location,
                      style: hitamreguler12.copyWith(color: textColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // SECTION JAM BUKA: Kiri (Jam & Hari Buka) & Kanan (Kecuali)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.access_time, color: textColor, size: 16),
                  const SizedBox(width: 10),

                  // SISI KIRI: Jam Buka & Keterangan Hari Buka
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayJamBuka,
                          style: hitamreguler12.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (displayHariBuka.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            displayHariBuka,
                            style: hitamreguler12.copyWith(
                              color: textColor.withValues(alpha: 0.75),
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // SISI KANAN: Keterangan Pengecualian (Kecuali Hari ...)
                  if (displayKecualiHari.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.redAccent.withValues(alpha: 0.4),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        displayKecualiHari,
                        style: hitamreguler12.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Deskripsi Dinamis
          _buildDescriptionSection(textColor, subTextColor, descriptionText),
          const SizedBox(height: 20),

          // Galeri Foto Horizontal
          _buildGallerySection(),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(
    Color textColor,
    Color subTextColor,
    String descriptionText,
  ) {
    final String currentLang = Localizations.localeOf(context).languageCode;
    final String title = currentLang == 'en' ? 'Description' : 'Deskripsi';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: hitamBold15.copyWith(color: textColor)),
        const SizedBox(height: 8),
        Text(
          descriptionText,
          style: hitamreguler12.copyWith(color: subTextColor, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildGallerySection() {
    final List<String> images = widget.place.imageUrls;

    if (images.isEmpty) return const SizedBox.shrink();

    return Center(
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            final imagePath = images[index];
            return GestureDetector(
              onTap: () => _showImagePreview(context, index),
              child: Container(
                width: 70,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(Color buttonBgColor, Color buttonTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: GestureDetector(
        onTap: () => _openMap(widget.place.linklocation),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: buttonBgColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              Localizations.localeOf(context).languageCode == 'en'
                  ? 'Explore Location'
                  : 'Jelajahi Lokasi',
              style: hitamBold15.copyWith(color: buttonTextColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? bgColor,
    Color? iconColor,
    double size = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor ?? hitam.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? putih, size: size * 0.5),
      ),
    );
  }
}
