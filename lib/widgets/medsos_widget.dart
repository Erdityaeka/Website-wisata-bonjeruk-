import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/controller/home_controller.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MedsosWidget extends StatelessWidget {
  final HomeController controller;

  const MedsosWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : hitam;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Divider(color: textColor.withOpacity(0.5), thickness: 1),
        const SizedBox(height: 10),
        Text(
          l10n?.socialMediaTitle ?? 'Social Media 📸',
          textAlign: TextAlign.center,
          style: hitamBold15.copyWith(color: textColor),
        ),
        const SizedBox(height: 10),
        _socialMediaLinks(l10n, textColor),
      ],
    );
  }

  Widget _socialMediaLinks(AppLocalizations? l10n, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        // CARD WEBSITE
        _buildSocialCard(
          url: 'https://tourismbonjeruk.com/',
          iconPath: 'images/web.png',
          title: l10n?.website ?? 'Website',
          description:
              l10n?.websiteDescription ??
              "Discover Bonjeruk's journey regarding sustainability, culture, and identity through the website.",
          textColor: textColor,
        ),

        const SizedBox(height: 10),

        // CARD INSTAGRAM
        _buildSocialCard(
          url:
              'https://www.instagram.com/desawisatabonjeruk?igsh=NjQ4OXVkMmVnZDh1',
          iconPath: 'images/instagram.png',
          title: l10n?.instagram ?? 'Instagram',
          description:
              l10n?.instagramDescription ??
              "Discover the journey in the Bonjeruk tourism village and follow us on Instagram.",
          textColor: textColor,
        ),

        const SizedBox(height: 10),

        // CARD FACEBOOK
        _buildSocialCard(
          url: 'https://www.facebook.com/share/1FEmDzt5o6/',
          iconPath: 'images/fb.webp',
          title: l10n?.facebook ?? 'Facebook',
          description:
              l10n?.facebookDescription ??
              "Discover the journey in the Bonjeruk tourism village and follow us on Facebook.",
          textColor: textColor,
        ),
      ],
    );
  }

  // Helper Widget
  Widget _buildSocialCard({
    required String url,
    required String iconPath,
    required String title,
    required String description,
    required Color textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => controller.launchURL(url),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: textColor.withOpacity(0.5), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Center(
                    child: Image.asset(iconPath, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: hitamBold15.copyWith(color: textColor),
                        
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: hitamreguler12.copyWith(color: textColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, color: textColor, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
