import 'dart:async';
import 'package:desa_bonjeruk/Screens/home_screens.dart';
import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreens()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : hitam;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Logo Desa Wisata
              Image.asset("images/desa.png", width: 200, fit: BoxFit.contain),

              const SizedBox(height: 30),

              // Indikator Loading
              CircularProgressIndicator(color: hijau, strokeWidth: 3),

              const Spacer(),

              // Teks Hak Cipta
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  children: [
                    Text(
                      l10n?.supportedBy ?? 'Supported by',
                      style: hitamreguler15.copyWith(color: textColor),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/kkn.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'x',
                          style: hitamBold15.copyWith(color: textColor),
                        ),
                        SizedBox(width: 5),
                        Image.asset(
                          "images/desa.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
