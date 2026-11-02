import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'My Application'**
  String get appTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our application!'**
  String get welcomeMessage;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginButton;

  /// No description provided for @supportedBy.
  ///
  /// In en, this message translates to:
  /// **'Supported by'**
  String get supportedBy;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Desa Bonjeruk'**
  String get homeTitle;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Bonjeruk’s journey does not end with its declaration as a tourism village — it continues to evolve, guided by a deep commitment to sustainability and the dreams of its ancestors. The people of Bonjeruk believe that a truly beautiful village is one that is clean in its environment, rich in its culture, independent in its economy, and strong in its identity.'**
  String get homeDescription;

  /// No description provided for @welcomeInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Bonjeruk Village Digital Information Center 🌿.'**
  String get welcomeInfoTitle;

  /// No description provided for @locationAddress.
  ///
  /// In en, this message translates to:
  /// **'Desa Bonjeruk, Kecamatan Jonggat Kabupaten Lombok Tengah Nusa Tenggara Barat Indonesia 83561'**
  String get locationAddress;

  /// No description provided for @openHours.
  ///
  /// In en, this message translates to:
  /// **'Monday – Sunday 8 AM – 5 PM'**
  String get openHours;

  /// No description provided for @socialMediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Social Media 📸'**
  String get socialMediaTitle;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @tiktok.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get tiktok;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @websiteDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover Bonjeruk\'s journey regarding sustainability, culture, and identity through the website.'**
  String get websiteDescription;

  /// No description provided for @instagramDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the journey in the Bonjeruk tourism village and follow us on Instagram.'**
  String get instagramDescription;

  /// No description provided for @facebookDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the journey in the Bonjeruk tourism village and follow us on Facebook.'**
  String get facebookDescription;

  /// No description provided for @tiktokDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the journey in the Bonjeruk tourism village and follow us on TikTok.'**
  String get tiktokDescription;

  /// No description provided for @whatsappDescription.
  ///
  /// In en, this message translates to:
  /// **'Contact us on WhatsApp for information and tourism services in Bonjeruk Village.'**
  String get whatsappDescription;

  /// No description provided for @homewelcometitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Tourists 🖐️'**
  String get homewelcometitle;

  /// No description provided for @homewelcomesubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start Gathering Information at Bonjeruk Tourism Village.'**
  String get homewelcomesubtitle;

  /// No description provided for @locationWisataKuliner.
  ///
  /// In en, this message translates to:
  /// **'Location Wisata Kuliner'**
  String get locationWisataKuliner;

  /// No description provided for @descriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionTitle;

  /// No description provided for @exploreLocation.
  ///
  /// In en, this message translates to:
  /// **'Explore Location'**
  String get exploreLocation;

  /// No description provided for @mapUrlNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Map link is not available'**
  String get mapUrlNotAvailable;

  /// No description provided for @cannotOpenMapUrl.
  ///
  /// In en, this message translates to:
  /// **'Cannot open map link'**
  String get cannotOpenMapUrl;

  /// No description provided for @openingHoursNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Opening hours not available'**
  String get openingHoursNotAvailable;

  /// No description provided for @kknGroup.
  ///
  /// In en, this message translates to:
  /// **'Community Service Program (KKN) Group 17'**
  String get kknGroup;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
