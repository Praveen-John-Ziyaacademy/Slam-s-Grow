import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:social_media/auth_screen/new_password.dart';

class OTPController extends GetxController {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  final secondsRemaining = 52.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    if (secondsRemaining.value == 0) {
      secondsRemaining.value = 52;
      startTimer();
      for (var controller in controllers) {
        controller.clear();
      }
      if (focusNodes.isNotEmpty) {
        focusNodes[0].requestFocus();
      }
      Get.snackbar(
        'OTP Resent',
        'A new OTP has been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void onOTPChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    // Check if all 4 fields are filled
    if (index == 3 && value.isNotEmpty) {
      checkIfOTPComplete();
    }
  }

  void checkIfOTPComplete() {
    String otp = getOTP();
    if (otp.length == 4) {
      // Auto navigate to new password screen when all 4 digits are filled
      Get.to(() => NewPasswordScreen());
    }
  }

  String getOTP() {
    return controllers.map((controller) => controller.text).join();
  }

  void goBack() {
    Get.back();
  }
}
