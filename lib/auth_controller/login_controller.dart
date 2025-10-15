import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/auth_screen/forgot_password.dart';
import 'package:social_media/auth_screen/sign_up_screen.dart';
import 'package:social_media/components/bottom_bar.dart';
import 'package:social_media/components/loading.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final obscurePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

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

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void _loadSavedCredentials() {
    try {
      final savedEmail = storage.read('saved_email');
      final savedPassword = storage.read('saved_password');
      final remember = storage.read('remember_me') ?? false;

      print('Saved Email: $savedEmail');
      print('Remember Me: $remember');

      if (remember && savedEmail != null && savedPassword != null) {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        rememberMe.value = true;
      }
    } catch (e) {
      debugPrint('Error loading saved credentials: $e');
    }
  }

  void _saveCredentials() {
    try {
      if (rememberMe.value) {
        storage.write('saved_email', emailController.text.trim());
        storage.write('saved_password', passwordController.text.trim());
        storage.write('remember_me', true);
      } else {
        storage.remove('saved_email');
        storage.remove('saved_password');
        storage.write('remember_me', false);
      }
    } catch (e) {
      debugPrint('Error saving credentials: $e');
    }
  }

  void _saveUserSession(Map<String, dynamic> userData) {
    try {
      print('User Data: $userData');
      if (userData['token'] != null) {
        storage.write('auth_token', userData['token']);
      }
      if (userData['user_id'] != null) {
        storage.write('user_id', userData['user_id'].toString());
      }
      if (userData['email'] != null) {
        storage.write('user_email', userData['email']);
      }
      if (userData['name'] != null) {
        storage.write('user_name', userData['name']);
      }

      storage.write('is_logged_in', true);
    } catch (e) {
      debugPrint('Error saving user session: $e');
    }
  }

  void login() async {
    // String email = emailController.text.trim();
    // String password = passwordController.text.trim();

    // if (email.isEmpty || password.isEmpty) {
    //   Get.snackbar(
    //     'Error',
    //     'Please enter email and password',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red.withOpacity(0.7),
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    // if (!GetUtils.isEmail(email)) {
    //   Get.snackbar(
    //     'Error',
    //     'Please enter a valid email address',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red.withOpacity(0.7),
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    // showLoading();

    // try {
    //   final result = await ApiService.login(email: email, password: password);

    //   hideLoading();

    //   if (result['success']) {
    //     _saveCredentials();

    //     _saveUserSession(result['data']);

    //     Get.snackbar(
    //       'Success',
    //       'Login successful!',
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.green.withOpacity(0.7),
    //       colorText: Colors.white,
    //     );

    //     Get.offAll(() => HomePage());
    //   } else {
    //     Get.snackbar(
    //       'Login Failed',
    //       result['message'] ?? 'Invalid credentials',
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red.withOpacity(0.7),
    //       colorText: Colors.white,
    //       duration: const Duration(seconds: 3),
    //     );
    //   }
    // } catch (e) {
    //   hideLoading();
    //   Get.snackbar(
    //     'Error',
    //     'An unexpected error occurred: ${e.toString()}',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red.withOpacity(0.7),
    //     colorText: Colors.white,
    //   );
    // }
    Get.to(() => HomePage());
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

class ApiService {
  static const String baseUrl = 'http://192.168.1.3:8000/api';

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login/');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/register/');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/forgot-password/');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Request failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
