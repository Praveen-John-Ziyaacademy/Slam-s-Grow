import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/components/bottom_bar.dart';
import 'dart:async';
import 'package:social_media/components/loading.dart';

class LoginOtpController extends GetxController {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  final secondsRemaining = 52.obs;
  Timer? _timer;

  final email = ''.obs;
  final userId = ''.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    startTimer();

    Future.delayed(Duration(milliseconds: 800), () async {
      if (email.value.isNotEmpty) {
        await sendOTP();

        _hideLoginLoading();
      }
    });
  }

  void _hideLoginLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void _loadUserData() {
    try {
      final userEmail = storage.read('email');
      final userIdValue = storage.read('id');

      if (userEmail != null) {
        email.value = userEmail;
      }

      if (userIdValue != null) {
        userId.value = userIdValue;
      }

      print('Loaded - Email: ${email.value}, UserId: ${userId.value}');
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
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

  Future<void> sendOTP() async {
    try {
      final accessToken = storage.read('access');

      if (accessToken == null) {
        Get.snackbar(
          'Error',
          'Authentication token not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
        );
        return;
      }

      if (email.value.isEmpty) {
        Get.snackbar(
          'Error',
          'Email not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
        );
        return;
      }

      print('Sending OTP to: ${email.value}');
      print('Using token: $accessToken');

      final url = Uri.parse('http://192.168.1.21:8000/api/send-otp/');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'email': email.value}),
      );

      print('Send OTP Response Status: ${response.statusCode}');
      print('Send OTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          data['message'] ?? 'OTP sent successfully to ${email.value}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
        );
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Failed to send OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Send OTP Error: $e');
      Get.snackbar(
        'Error',
        'Network error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
    }
  }

  void resendOTP() async {
    if (secondsRemaining.value == 0) {
      for (var controller in controllers) {
        controller.clear();
      }

      if (focusNodes.isNotEmpty) {
        focusNodes[0].requestFocus();
      }

      secondsRemaining.value = 52;
      startTimer();

      await sendOTP();
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

    if (index == 3 && value.isNotEmpty) {
      checkIfOTPComplete();
    }
  }

  void checkIfOTPComplete() {
    String otp = getOTP();
    if (otp.length == 4) {
      verifyOTP();
    }
  }

  String getOTP() {
    return controllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOTP() async {
    String otp = getOTP();

    if (otp.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter all 4 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      Center(child: SingleCircleLoader(size: 80)),
      barrierDismissible: false,
    );

    try {
      final accessToken = storage.read('access');
      final userIdValue = storage.read('id');

      if (accessToken == null || userIdValue == null) {
        if (Get.isDialogOpen ?? false) Get.back();

        Get.snackbar(
          'Error',
          'Session expired. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
        );
        return;
      }

      print('Verifying OTP: $otp');
      print('User ID: $userIdValue');
      print('Using token: $accessToken');

      final url = Uri.parse('http://192.168.1.21:8000/api/verify-otp/');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'user_id': userIdValue, 'otp': otp}),
      );

      print('Verify OTP Response Status: ${response.statusCode}');
      print('Verify OTP Response Body: ${response.body}');

      if (Get.isDialogOpen ?? false) Get.back();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          data['message'] ?? 'OTP verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
        );

        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAll(() => HomePage());
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Invalid OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
        );

        for (var controller in controllers) {
          controller.clear();
        }
        focusNodes[0].requestFocus();
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();

      print('Verify OTP Error: $e');
      Get.snackbar(
        'Error',
        'Network error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
    }
  }

  void goBack() {
    Get.back();
  }

  void setContactInfo({String? emailAddress}) {
    if (emailAddress != null) email.value = emailAddress;
  }
}
