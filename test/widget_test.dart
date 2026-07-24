// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:desa_bonjeruk/Screens/home_screens.dart';
import 'package:desa_bonjeruk/controller/app_locale_controller.dart';
import 'package:desa_bonjeruk/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'translate button switches locale between Indonesian and English',
    (WidgetTester tester) async {
      AppLocaleController.locale.value = const Locale('id');

      await tester.pumpWidget(
        ValueListenableBuilder<Locale>(
          valueListenable: AppLocaleController.locale,
          builder: (context, locale, _) {
            return MaterialApp(
              locale: locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const HomeScreens(),
            );
          },
        ),
      );

      expect(find.byIcon(Icons.translate), findsOneWidget);
      expect(
        Localizations.localeOf(
          tester.element(find.byType(HomeScreens)),
        ).languageCode,
        'id',
      );

      await tester.tap(find.byIcon(Icons.translate));
      await tester.pump();

      expect(
        Localizations.localeOf(
          tester.element(find.byType(HomeScreens)),
        ).languageCode,
        'en',
      );
    },
  );
}
