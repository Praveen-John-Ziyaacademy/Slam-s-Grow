import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_ta.dart';

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
    Locale('hi'),
    Locale('ml'),
    Locale('ta'),
  ];

  /// No description provided for @onboard_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip >>'**
  String get onboard_skip;

  /// No description provided for @onboard_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboard_get_started;

  /// No description provided for @onboard_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboard_next;

  /// No description provided for @onboard_heading1.
  ///
  /// In en, this message translates to:
  /// **'Welcome !'**
  String get onboard_heading1;

  /// No description provided for @onboard_title1.
  ///
  /// In en, this message translates to:
  /// **'Complete simple tasks'**
  String get onboard_title1;

  /// No description provided for @onboard_desc1.
  ///
  /// In en, this message translates to:
  /// **'Complete small tasks and activities to start earnings'**
  String get onboard_desc1;

  /// No description provided for @onboard_heading2.
  ///
  /// In en, this message translates to:
  /// **'Earn !'**
  String get onboard_heading2;

  /// No description provided for @onboard_title2.
  ///
  /// In en, this message translates to:
  /// **'Real rewards and cash.'**
  String get onboard_title2;

  /// No description provided for @onboard_desc2.
  ///
  /// In en, this message translates to:
  /// **'Get paid in cash for the tasks you complete and offers you engage with.'**
  String get onboard_desc2;

  /// No description provided for @onboard_heading3.
  ///
  /// In en, this message translates to:
  /// **'Join !'**
  String get onboard_heading3;

  /// No description provided for @onboard_title3.
  ///
  /// In en, this message translates to:
  /// **'Our community and grow.'**
  String get onboard_title3;

  /// No description provided for @onboard_desc3.
  ///
  /// In en, this message translates to:
  /// **'Connect with other users and elevate your user level'**
  String get onboard_desc3;

  /// No description provided for @onboard_login.
  ///
  /// In en, this message translates to:
  /// **'Login to Continue'**
  String get onboard_login;

  /// No description provided for @onboard_or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get onboard_or;

  /// No description provided for @onboard_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get onboard_email;

  /// No description provided for @onboard_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get onboard_password;

  /// No description provided for @onboard_remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get onboard_remember_me;

  /// No description provided for @onboard_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get onboard_forgot_password;

  /// No description provided for @onboard_login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get onboard_login_button;

  /// No description provided for @onboard_dont_h_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get onboard_dont_h_account;

  /// No description provided for @onboard_signup_button.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get onboard_signup_button;

  /// No description provided for @onboard_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree that you have read and accepted our T&C and privacy policy'**
  String get onboard_privacy_policy;

  /// No description provided for @onboard_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up your Account'**
  String get onboard_sign_up;

  /// No description provided for @onboard_personal_data.
  ///
  /// In en, this message translates to:
  /// **'Enter your personal data to create account'**
  String get onboard_personal_data;

  /// No description provided for @onboard_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get onboard_have_account;

  /// No description provided for @onboard_first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get onboard_first_name;

  /// No description provided for @onboard_last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get onboard_last_name;

  /// No description provided for @onboard_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get onboard_phone;

  /// No description provided for @onboard_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get onboard_confirm_password;

  /// No description provided for @onboard_reference_number.
  ///
  /// In en, this message translates to:
  /// **'Reference Number'**
  String get onboard_reference_number;
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
      <String>['en', 'hi', 'ml', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ml':
      return AppLocalizationsMl();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
