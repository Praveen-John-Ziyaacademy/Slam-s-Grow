import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/auth_screen/kyc_verification.dart';
import 'package:social_media/components/loading.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referenceController = TextEditingController();

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  void showLoading() {
    Get.dialog(
      Center(child: SingleCircleLoader(size: 80)),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  bool validateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    if (passwordController.text.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void signUp() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final url = Uri.parse('http://192.168.1.25:8000/api/register/');
    print('📤 Sending sign-up request to: $url');
    print('Request body:');
    print(
      jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phone,
        "password": password,
        "confirm_password": confirmPassword,
        "reference_code": referenceController.text,
      }),
    );
    showLoading();

    await Future.delayed(const Duration(seconds: 2));
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone_number": phone,
          "password": password,
          "confirm_password": confirmPassword,
          "reference_code": referenceController.text,
        }),
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('✅ Parsed response: $data');

        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
        );

        Get.to(() => KYCVerificationScreen());
      } else {
        final error = jsonDecode(response.body);
        print('❌ Error response: $error');

        Get.snackbar(
          'Error ${response.statusCode}',
          error['message'] ?? 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('🚨 Exception: $e');
      Get.snackbar(
        'Error',
        'Failed to connect to server: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      hideLoading();
    }
  }

  void signUpWithGoogle() {
    Get.snackbar(
      'Google Sign Up',
      'Google sign up not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void signUpWithFacebook() {
    Get.snackbar(
      'Facebook Sign Up',
      'Facebook sign up not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToLogin() {
    Get.back();
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    if (value.length < 2) {
      return 'First name must be at least 2 characters';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    if (value.length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Simple email validation
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateReference(String? value) {
    // Reference is optional, so we can return null
    return null;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referenceController.dispose();
    super.onClose();
  }
}
