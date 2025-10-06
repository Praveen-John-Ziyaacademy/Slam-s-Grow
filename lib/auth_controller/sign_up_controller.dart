import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_screen/kyc_verification.dart';

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

  void signUp() {
    // if (
    //   // !validateForm()
    //   ) {
    //   return;
    // }

    // String firstName = firstNameController.text.trim();
    // String lastName = lastNameController.text.trim();
    // String email = emailController.text.trim();
    // String phone = phoneController.text.trim();
    // String password = passwordController.text.trim();
    // String reference = referenceController.text.trim();

    // Get.snackbar(
    //   'Sign Up',
    //   'Creating account for: $firstName $lastName',
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: Colors.green.withOpacity(0.7),
    //   colorText: Colors.white,
    // );
    Get.to(() => KYCVerificationScreen());
  }

  void signUpWithGoogle() {
    // TODO: Implement Google sign up
    Get.snackbar(
      'Google Sign Up',
      'Google sign up not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Facebook sign up
  void signUpWithFacebook() {
    // TODO: Implement Facebook sign up
    Get.snackbar(
      'Facebook Sign Up',
      'Facebook sign up not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Navigate to login screen
  void navigateToLogin() {
    // TODO: Navigate to login screen
    Get.back(); // or Get.toNamed('/login');
  }

  // Validate individual fields
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
