import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media/auth_screen/forgot_password.dart';
import 'package:social_media/auth_screen/kyc_verification.dart';
import 'package:social_media/auth_screen/new_password.dart';
import 'package:social_media/auth_screen/otp_verification.dart';
import 'package:social_media/components/bottom_bar.dart';
import 'package:social_media/l10n/app_localizations.dart';
import 'package:social_media/l10n/app_localizations_en.dart';
import 'package:social_media/screens/home/home_screen.dart';
import 'package:social_media/screens/onboarding/onboarding_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final savedLocale = box.read('locale') ?? 'en';

    return GetMaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      locale: Locale(savedLocale),
      fallbackLocale: Locale('en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('ml'),
        Locale('ta'),
      ],
      home: HomePage(),
    );
  }
}
