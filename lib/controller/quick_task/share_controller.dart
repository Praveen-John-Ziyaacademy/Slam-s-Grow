import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ScreenshotController extends GetxController {
  final whatsappImage = Rx<File?>(null);
  final facebookImage = Rx<File?>(null);
  final instagramImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final isLoading = false.obs;
  final storage = GetStorage();

  bool get canSubmit =>
      whatsappImage.value != null ||
      facebookImage.value != null ||
      instagramImage.value != null;

  Future<void> pickImage(String type) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        switch (type) {
          case 'whatsapp':
            whatsappImage.value = File(image.path);
            break;
          case 'facebook':
            facebookImage.value = File(image.path);
            break;
          case 'instagram':
            instagramImage.value = File(image.path);
            break;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
    }
  }

  void removeImage(String type) {
    switch (type) {
      case 'whatsapp':
        whatsappImage.value = null;
        break;
      case 'facebook':
        facebookImage.value = null;
        break;
      case 'instagram':
        instagramImage.value = null;
        break;
    }
  }

  Future<void> submitScreenshots() async {
    if (!canSubmit) {
      Get.snackbar(
        'Error',
        'Please upload at least one screenshot',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    // Get the access token from storage
    final accessToken = storage.read('access');

    if (accessToken == null) {
      Get.snackbar(
        'Error',
        'Please login first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('http://192.168.1.22:8000/api/upload-screenshot/');
      final request = http.MultipartRequest('POST', url);

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $accessToken';

      // Add screenshot files to the request
      if (whatsappImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'whatsapp_screenshot',
            whatsappImage.value!.path,
          ),
        );
      }

      if (facebookImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'facebook_screenshot',
            facebookImage.value!.path,
          ),
        );
      }

      if (instagramImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'instagram_screenshot',
            instagramImage.value!.path,
          ),
        );
      }

      print('Sending request to: ${url.toString()}');
      print('Files attached: ${request.files.length}');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Screenshots uploaded successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Clear the images after successful upload
        whatsappImage.value = null;
        facebookImage.value = null;
        instagramImage.value = null;

        // Navigate back or to another screen if needed
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Authentication Error',
          'Your session has expired. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        // Optionally navigate to login screen
        // Get.offAll(() => LoginScreen());
      } else {
        Get.snackbar(
          'Upload Failed',
          'Failed to upload screenshots. Status: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      isLoading.value = false;
      print('Upload Error: $e');
      Get.snackbar(
        'Error',
        'Network error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
