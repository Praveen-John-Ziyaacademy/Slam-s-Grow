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

  /// No description provided for @onboard_kyc_title.
  ///
  /// In en, this message translates to:
  /// **'KYC Verification'**
  String get onboard_kyc_title;

  /// No description provided for @onboard_kyc_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your information is securely stored & encrypted'**
  String get onboard_kyc_subtitle;

  /// No description provided for @onboard_personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get onboard_personal_info;

  /// No description provided for @onboard_id_verification.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get onboard_id_verification;

  /// No description provided for @onboard_review_submit.
  ///
  /// In en, this message translates to:
  /// **'Review & Submit'**
  String get onboard_review_submit;

  /// No description provided for @onboard_personal_information.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get onboard_personal_information;

  /// No description provided for @onboard_full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get onboard_full_name;

  /// No description provided for @onboard_nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get onboard_nationality;

  /// No description provided for @onboard_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get onboard_gender;

  /// No description provided for @onboard_marital_status.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get onboard_marital_status;

  /// No description provided for @onboard_blood_group.
  ///
  /// In en, this message translates to:
  /// **'\'Blood Group'**
  String get onboard_blood_group;

  /// No description provided for @onboard_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get onboard_date_of_birth;

  /// No description provided for @onboard_state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get onboard_state;

  /// No description provided for @onboard_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get onboard_city;

  /// No description provided for @onboard_district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get onboard_district;

  /// No description provided for @onboard_pin_code.
  ///
  /// In en, this message translates to:
  /// **'Pin code'**
  String get onboard_pin_code;

  /// No description provided for @onboard_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get onboard_mobile_number;

  /// No description provided for @onboard_another_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Another Mobile Number'**
  String get onboard_another_mobile_number;

  /// No description provided for @onboard_professional_details.
  ///
  /// In en, this message translates to:
  /// **'Professional Details'**
  String get onboard_professional_details;

  /// No description provided for @onboard_job_role.
  ///
  /// In en, this message translates to:
  /// **'Job Role'**
  String get onboard_job_role;

  /// No description provided for @onboard_user_type.
  ///
  /// In en, this message translates to:
  /// **'User Type'**
  String get onboard_user_type;

  /// No description provided for @onboard_account_details.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get onboard_account_details;

  /// No description provided for @onboard_account_number.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get onboard_account_number;

  /// No description provided for @onboard_ifsc_code.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code'**
  String get onboard_ifsc_code;

  /// No description provided for @onboard_upload_documents.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get onboard_upload_documents;

  /// No description provided for @onboard_aadhar_card.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Card'**
  String get onboard_aadhar_card;

  /// No description provided for @onboard_pan_card.
  ///
  /// In en, this message translates to:
  /// **'Pan Card'**
  String get onboard_pan_card;

  /// No description provided for @onboard_pass_book.
  ///
  /// In en, this message translates to:
  /// **'Pass Book'**
  String get onboard_pass_book;

  /// No description provided for @onboard_selfie.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get onboard_selfie;

  /// No description provided for @onboard_upload_back.
  ///
  /// In en, this message translates to:
  /// **'Upload Back'**
  String get onboard_upload_back;

  /// No description provided for @onboard_spot_selfie.
  ///
  /// In en, this message translates to:
  /// **'Spot Selfie'**
  String get onboard_spot_selfie;

  /// No description provided for @onboard_uploaded_documents.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Documents'**
  String get onboard_uploaded_documents;

  /// No description provided for @onboard_confirm_information.
  ///
  /// In en, this message translates to:
  /// **'I confirm my information is correct'**
  String get onboard_confirm_information;

  /// No description provided for @onboard_agree_terms.
  ///
  /// In en, this message translates to:
  /// **'I agree to T&C and Privacy Policy'**
  String get onboard_agree_terms;

  /// No description provided for @onboard_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get onboard_submit;

  /// No description provided for @onboard_forgot_title.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get onboard_forgot_title;

  /// No description provided for @onboard_email_adress.
  ///
  /// In en, this message translates to:
  /// **'Enter Email Address'**
  String get onboard_email_adress;

  /// No description provided for @onboard_back_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get onboard_back_sign_in;

  /// No description provided for @onboard_get_otp.
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get onboard_get_otp;

  /// No description provided for @onboard_verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get onboard_verification;

  /// No description provided for @onboard_4_digit.
  ///
  /// In en, this message translates to:
  /// **'An 4 digit OTP has been sent to\n'**
  String get onboard_4_digit;

  /// No description provided for @onboard_wait_for.
  ///
  /// In en, this message translates to:
  /// **'Wait for'**
  String get onboard_wait_for;

  /// No description provided for @onboard_resend_otp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get onboard_resend_otp;

  /// No description provided for @onboard_new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get onboard_new_password;

  /// No description provided for @onboard_enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get onboard_enter_new_password;

  /// No description provided for @onboard_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get onboard_welcome_back;

  /// No description provided for @onboard_home_title.
  ///
  /// In en, this message translates to:
  /// **'John Samual'**
  String get onboard_home_title;

  /// No description provided for @onboard_available_bal.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get onboard_available_bal;

  /// No description provided for @onboard_view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details >'**
  String get onboard_view_details;

  /// No description provided for @onboard_tasks_h1.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get onboard_tasks_h1;

  /// No description provided for @onboard_rank_h1.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get onboard_rank_h1;

  /// No description provided for @onboard_days_h1.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get onboard_days_h1;

  /// No description provided for @onboard_manage_now.
  ///
  /// In en, this message translates to:
  /// **'Manage Now'**
  String get onboard_manage_now;

  /// No description provided for @onboard_my_wallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get onboard_my_wallet;

  /// No description provided for @onboard_view_transactions.
  ///
  /// In en, this message translates to:
  /// **'View Transactions'**
  String get onboard_view_transactions;

  /// No description provided for @onboard_leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get onboard_leaderboard;

  /// No description provided for @onboard_check_your_rank.
  ///
  /// In en, this message translates to:
  /// **'Check your Rank'**
  String get onboard_check_your_rank;

  /// No description provided for @onboard_ad_sharing.
  ///
  /// In en, this message translates to:
  /// **'Ad Sharing'**
  String get onboard_ad_sharing;

  /// No description provided for @onboard_social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get onboard_social;

  /// No description provided for @onboard_survey.
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get onboard_survey;

  /// No description provided for @onboard_todays_task.
  ///
  /// In en, this message translates to:
  /// **'Todays Task\'s'**
  String get onboard_todays_task;

  /// No description provided for @onboard_view_all.
  ///
  /// In en, this message translates to:
  /// **'View All >'**
  String get onboard_view_all;

  /// No description provided for @onboard_do_task.
  ///
  /// In en, this message translates to:
  /// **'Do Task'**
  String get onboard_do_task;

  /// No description provided for @onboard_recent_activity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get onboard_recent_activity;

  /// No description provided for @onboard_quick_task.
  ///
  /// In en, this message translates to:
  /// **'Quick Task'**
  String get onboard_quick_task;

  /// No description provided for @onboard_earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get onboard_earn;

  /// No description provided for @onboard_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get onboard_points;
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
