import 'package:flutter/material.dart';

class AppLocaleController {
  static final ValueNotifier<Locale> locale = ValueNotifier(const Locale('id'));

  static void toggleLocale() {
    final current = locale.value.languageCode;
    locale.value = current == 'en' ? const Locale('id') : const Locale('en');
  }
}
