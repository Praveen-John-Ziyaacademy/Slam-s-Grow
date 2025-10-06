import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_screen/forgot_password.dart';
import 'package:social_media/auth_screen/kyc_verification.dart';
import 'package:social_media/auth_screen/sign_up_screen.dart';

class LoginController extends GetxController {
  final rememberMe = true.obs;
  final obscurePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.to(() => KYCVerificationScreen());

    Get.snackbar(
      'Login',
      'Logging in with: $email',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void navigateToSignUp() {
    Get.to(() => SignUpScreen());
  }

  void loginWithGoogle() {
    Get.snackbar(
      'Google Login',
      'Google login not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithFacebook() {
    Get.snackbar(
      'Facebook Login',
      'Facebook login not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void forgotPassword() {
    Get.to(() => ForgotPasswordScreen());
  }

  void navigateNext() {
    // TODO: Navigate to your next screen

    Get.snackbar(
      'Next',
      'Navigation not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
