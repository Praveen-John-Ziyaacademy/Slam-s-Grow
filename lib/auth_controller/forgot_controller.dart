import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_screen/new_password.dart';
import 'package:social_media/auth_screen/otp_verification.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final emailError = ''.obs;

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
    emailError.value = '';
    return true;
  }

  Future<void> getOTP() async {
    // if (!validateEmail(emailController.text)) {
    //   return;
    // }

    // isLoading.value = true;
    // try {
    //   // Simulate API call
    //   await Future.delayed(const Duration(seconds: 2));

    //   // Navigate to OTP screen or show success message
    //   Get.snackbar(
    //     'Success',
    //     'OTP sent to ${emailController.text}',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.green,
    //     colorText: Colors.white,
    //   );

    //   // Navigate to OTP verification screen
    //   // Get.to(() => OtpVerificationScreen());
    // } catch (e) {
    //   Get.snackbar(
    //     'Error',
    //     'Failed to send OTP. Please try again.',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // } finally {
    //   isLoading.value = false;
    // }
    Get.to(() => OTPVerificationScreen());
  }

  void loginWithGoogle() {
    Get.snackbar(
      'Google Login',
      'Google authentication initiated',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Implement Google login
  }

  void loginWithApple() {
    Get.snackbar(
      'Apple Login',
      'Apple authentication initiated',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Implement Apple login
  }

  void loginWithFacebook() {
    Get.snackbar(
      'Facebook Login',
      'Facebook authentication initiated',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Implement Facebook login
  }

  void goToSignIn() {
    Get.back();
  }

  void goToSignUp() {
    Get.to(() => NewPasswordScreen());
    // Get.snackbar(
    //   'Sign Up',
    //   'Navigate to Sign Up screen',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }
}
