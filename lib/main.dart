import 'package:desa_bonjeruk/Theme/warna.dart';
import 'package:desa_bonjeruk/controller/app_locale_controller.dart';
import 'package:desa_bonjeruk/controller/app_theme_controller.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:desa_bonjeruk/splash%20screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocaleController.locale,
      builder: (context, locale, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: AppThemeController.themeMode,
          builder: (context, themeMode, _) {
            return MaterialApp(
              locale: locale,
              themeMode: themeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: putih,
                appBarTheme: AppBarTheme(backgroundColor: putih),
              ),
              darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
                scaffoldBackgroundColor: hitam,
                appBarTheme: AppBarTheme(
                  backgroundColor: hitam,
                  foregroundColor: putih,
                ),
              ),
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
