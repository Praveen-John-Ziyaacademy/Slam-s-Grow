import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_screen/kyc_verification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final isLoading = false.obs;

  final String baseUrl = 'http://192.168.1.54:8000/api';

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  bool validateForm() {
    // Check if first name is empty
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'First name is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    // Check if last name is empty
    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Last name is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    // Check if email is valid
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    // Check if phone is empty
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Phone number is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    // Check password length
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

    // Check if passwords match
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

    return true;
  }

  Future<void> signUp() async {
    // Validate form first
    if (!validateForm()) {
      return;
    }

    // Set loading state
    isLoading.value = true;

    try {
      // Prepare the data
      final Map<String, dynamic> requestData = {
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
      };

      // Add reference number only if it's not empty
      if (referenceController.text.trim().isNotEmpty) {
        requestData['reference_number'] = referenceController.text.trim();
      }

      // Make API request with timeout
      final response = await http
          .post(
            Uri.parse('$baseUrl/register/'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(requestData),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Connection timeout. Please check your network connection.',
              );
            },
          );

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        final responseData = json.decode(response.body);

        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
        );

        // Navigate to KYC verification
        Get.to(() => KYCVerificationScreen());
      } else {
        // Error from server
        final errorData = json.decode(response.body);
        String errorMessage = 'Registration failed';

        // Try to extract error message from response
        if (errorData is Map) {
          if (errorData.containsKey('message')) {
            errorMessage = errorData['message'];
          } else if (errorData.containsKey('error')) {
            errorMessage = errorData['error'];
          } else {
            // If there are field-specific errors
            errorMessage = errorData.values.first.toString();
          }
        }

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      // Network or other errors
      Get.snackbar(
        'Error',
        'Connection failed. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      print('Sign up error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void signUpWithGoogle() {
    // TODO: Implement Google sign up
    Get.snackbar(
      'Google Sign Up',
      'Google sign up not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void signUpWithFacebook() {
    // TODO: Implement Facebook sign up
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
