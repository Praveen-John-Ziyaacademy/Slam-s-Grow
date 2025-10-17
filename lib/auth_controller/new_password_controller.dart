import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:social_media/auth_controller/forgot_controller.dart';
import 'package:social_media/auth_controller/otp_controller.dart';

class NewPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> submitPassword() async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Get OTP from OTPController
      final otpController = Get.find<OTPController>();
      final otp = otpController.getOTP();

      // Get email from ForgotPasswordController
      final email = ForgotPasswordController.userEmail;

      final response = await http.post(
        Uri.parse('http://192.168.1.25:8000/api/forgot-password/reset/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'new_password': newPasswordController.text,
          'confirm_password': confirmPasswordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Password updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate back to login or home screen
        // Remove all previous screens and go to login
        Get.until((route) => route.isFirst);
        // Or use: Get.offAllNamed('/login'); if you have named routes
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Failed to reset password. Please try again.',
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

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
