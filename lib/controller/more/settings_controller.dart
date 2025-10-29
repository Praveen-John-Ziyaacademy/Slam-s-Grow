import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media/auth_screen/login_screen.dart';

class SettingsController extends GetxController {
  final userName = 'John Samuel K S'.obs;
  final userEmail = 'johnsamuelkls@gmail.com'.obs;
  final selectedLanguage = 'English'.obs;
  final selectedLocale = Locale('en').obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  void loadSavedLanguage() {
    final savedLocale = box.read('locale') ?? 'en';
    final savedLanguage = box.read('language') ?? 'English';

    selectedLanguage.value = savedLanguage;
    selectedLocale.value = Locale(savedLocale);
    Get.updateLocale(selectedLocale.value);
  }

  void showLanguageDialog() {
    final languages = {
      'English': 'en',
      'हिंदी': 'hi',
      'മലയാളം': 'ml',
      'தமிழ்': 'ta',
    };

    Get.dialog(
      AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.entries.map((entry) {
            return Obx(
              () => RadioListTile<String>(
                title: Text(entry.key),
                value: entry.key,
                groupValue: selectedLanguage.value,
                activeColor: const Color(0xFF2196F3),
                onChanged: (value) {
                  if (value != null) {
                    changeLanguage(value, entry.value);
                    Get.back();
                  }
                },
              ),
            );
          }).toList(),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ],
      ),
    );
  }

  void changeLanguage(String language, String localeCode) {
    selectedLanguage.value = language;
    selectedLocale.value = Locale(localeCode);

    // Save to storage
    box.write('language', language);
    box.write('locale', localeCode);

    // Update app locale
    Get.updateLocale(selectedLocale.value);

    Get.snackbar(
      'Language Changed',
      'App language changed to $language',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Get.to(() => LoginScreen());
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
