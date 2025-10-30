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
    loadUserInfo();
  }

  void loadUserInfo() {
    // Load user info from storage if available
    final savedFirstName = box.read('first_name') ?? '';
    final savedLastName = box.read('last_name') ?? '';
    final savedEmail = box.read('email') ?? '';

    if (savedFirstName.isNotEmpty || savedLastName.isNotEmpty) {
      userName.value = '$savedFirstName $savedLastName'.trim();
    }
    if (savedEmail.isNotEmpty) {
      userEmail.value = savedEmail;
    }
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
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Ok',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeLanguage(String language, String localeCode) {
    selectedLanguage.value = language;
    selectedLocale.value = Locale(localeCode);

    box.write('language', language);
    box.write('locale', localeCode);

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
              box.write('isLoggedIn', false);
              box.remove('access');
              box.remove('refresh');
              box.remove('id');
              box.remove('email');
              box.remove('first_name');
              box.remove('last_name');
              box.remove('phone_number');
              box.remove('role');

              Get.back();
              Get.offAll(() => LoginScreen());

              Get.snackbar(
                'Logged Out',
                'You have been successfully logged out',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.7),
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
