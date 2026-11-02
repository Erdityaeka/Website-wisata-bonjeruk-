import 'package:desa_bonjeruk/Screens/detail_sreens.dart';
import 'package:flutter/material.dart'; // Sesuaikan jika nama file detail_screens.dart
import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:desa_bonjeruk/model/place.dart';
import 'package:desa_bonjeruk/model/recomendation_place.dart';
import 'package:desa_bonjeruk/controller/home_controller.dart';

class LocationwisataWidget extends StatefulWidget {
  final HomeController? controller;

  const LocationwisataWidget({super.key, this.controller});

  @override
  State<LocationwisataWidget> createState() => _LocationwisataWidgetState();
}

class _LocationwisataWidgetState extends State<LocationwisataWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? putih : hitam;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Jarak & Divider
        const SizedBox(height: 25),
        Divider(color: textColor.withValues(alpha: 0.5), thickness: 1),
        const SizedBox(height: 10),

        // Judul Section
        Text(
          l10n?.locationWisataKuliner ?? 'Lokasi Wisata Kuliner 🌿',
          textAlign: TextAlign.center,
          style: hitamBold15.copyWith(color: textColor),
        ),
        const SizedBox(height: 15),

        // Carousel List Wisata
        Scrollbar(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: recomendationplace.length,
                itemBuilder: (context, index) {
                  final place = recomendationplace[index];
                  return _buildPlaceCard(
                    context: context,
                    place: place,
                    isDark: isDark,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceCard({
    required BuildContext context,
    required Place place,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 14.0),
      width: 200,
      child: Material(
        color: putih.withValues(alpha: 0.0), // Tanpa warna/transparan memakai variabel 'putih'
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(place: place),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? hitam.withValues(alpha: 0.5)
                      : hitam.withValues(alpha: 0.15),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0.2,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(place.imageAsset),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    hitam.withValues(alpha: 0.0),
                    hitam.withValues(alpha: 0.8),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: hitamBold15.copyWith(color: putih),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: putih,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place.location,
                          style: hitamreguler12.copyWith(color: putih),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}