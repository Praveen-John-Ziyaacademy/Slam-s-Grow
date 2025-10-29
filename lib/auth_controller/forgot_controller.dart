import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:social_media/auth_screen/otp_verification.dart';
import 'package:social_media/auth_screen/sign_up_screen.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final emailError = RxnString();

  // Store email for use in subsequent screens
  static String userEmail = '';

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email';
      return false;
    }
    emailError.value = null;
    return true;
  }

  void clearEmailError() {
    emailError.value = null;
  }

  Future<void> getOTP() async {
    if (!validateEmail(emailController.text)) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.25:8000/api/forgot-password/send-otp/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': emailController.text}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Store email for later use
        userEmail = emailController.text;

        Get.snackbar(
          'Success',
          'OTP sent to ${emailController.text}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to OTP verification screen with email as argument
        Get.to(
          () => const OTPVerificationScreen(),
          arguments: emailController.text, // Pass email here
        );
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Failed to send OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error. Please check your connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loginWithGoogle() {
    Get.snackbar(
      'Google Login',
      'Google authentication initiated',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithApple() {
    Get.snackbar(
      'Apple Login',
      'Apple authentication initiated',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithFacebook() {
    Get.snackbar(
      'Facebook Login',
      'Facebook authentication initiated',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void goToSignIn() {
    Get.back();
  }

  void goToSignUp() {
    Get.to(() => SignUpScreen());
  }
}
