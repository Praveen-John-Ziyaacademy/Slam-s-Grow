import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:social_media/auth_screen/login_screen.dart';

class SettingsController extends GetxController {
  final userName = 'John Samuel K S'.obs;
  final userEmail = 'johnsamuelkls@gmail.com'.obs;
  final selectedLanguage = 'English'.obs;

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.black)),
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
