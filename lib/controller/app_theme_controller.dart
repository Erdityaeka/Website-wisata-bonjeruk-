import 'package:flutter/material.dart';

class AppThemeController {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.light,
  );

  static void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
