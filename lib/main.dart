import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media/auth_screen/login_screen.dart';
import 'package:social_media/components/bottom_bar.dart';
import 'package:social_media/l10n/app_localizations.dart';
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

    final hasSeenOnboarding = box.read('hasSeenOnboarding') ?? false;

    final isLoggedIn = box.read('isLoggedIn') ?? false;

    Widget initialScreen;
    if (isLoggedIn) {
      initialScreen = HomePage();
    } else if (hasSeenOnboarding) {
      initialScreen = LoginScreen();
    } else {
      initialScreen = OnboardingScreen();
    }

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
      home: initialScreen,
    );
  }
}
