import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/controller/home_controller.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WelcomeInfoWidget extends StatelessWidget {
  final HomeController controller;

  const WelcomeInfoWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? putih : hitam;
    final iconColor = isDark ? putih : hijau;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        Divider(color: textColor.withOpacity(0.5), thickness: 1),
        const SizedBox(height: 10),
        Text(
          l10n?.welcomeInfoTitle ??
              'Welcome to the Bonjeruk Village Digital Information Center 🌿.',
          textAlign: TextAlign.center,
          style: hitamBold15.copyWith(color: textColor),
        ),
        const SizedBox(height: 10),
        _buildInformation(l10n, textColor, iconColor),
      ],
    );
  }

  Widget _buildInformation(
    AppLocalizations? l10n,
    Color textColor,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () => controller.launchURL(
            'https://maps.google.com/?q=Desa+Bonjeruk+Lombok+Tengah',
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n?.locationAddress ??
                      'Desa Bonjeruk, Kecamatan Jonggat Kabupaten Lombok Tengah Nusa Tenggara Barat Indonesia 83561',
                  style: hitamreguler12.copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => controller.launchURL('tel:+6287701508311'),
          child: Row(
            children: [
              Icon(Icons.phone, color: iconColor),
              const SizedBox(width: 10),
              Text(
                '+6287701508311',
                style: hitamreguler12.copyWith(color: textColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => controller.launchURL('mailto:wahyudelon99@gmail.com'),
          child: Row(
            children: [
              Icon(Icons.email, color: iconColor),
              const SizedBox(width: 10),
              Text(
                'wahyudelon99@gmail.com',
                style: hitamreguler12.copyWith(color: textColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.access_time, color: iconColor),
            const SizedBox(width: 10),
            Text(
              l10n?.openHours ?? 'Monday – Sunday 8 AM – 5 PM',
              style: hitamreguler12.copyWith(color: textColor),
            ),
          ],
        ),
      ],
    );
  }
}
