import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class KYCController extends GetxController {
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  final isChecked = false.obs;
  final selectedNationality = 'Nationality'.obs;
  final currentStep = 1.obs;

  // Document files
  final idDocument = Rx<File?>(null);
  final panDocument = Rx<File?>(null);

  // Nationality options
  final List<String> nationalityOptions = [
    'Nationality',
    'USA',
    'UK',
    'India',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
  ];

  // Toggle checkbox
  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  // Change nationality
  void changeNationality(String? value) {
    if (value != null) {
      selectedNationality.value = value;
    }
  }

  // Pick date of birth
  Future<void> pickDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 6570),
      ), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00BCD4),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateOfBirthController.text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  Future<void> uploadIDDocument() async {
    // TODO: Implement file picker logic
    // Example using image_picker or file_picker package:
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   idDocument.value = File(image.path);
    // }

    Get.snackbar(
      'Upload ID',
      'ID document upload functionality not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Upload PAN document
  Future<void> uploadPANDocument() async {
    // TODO: Implement file picker logic
    Get.snackbar(
      'Upload PAN',
      'PAN document upload functionality not implemented yet',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Validate form
  bool validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your full name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    if (dateOfBirthController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please select your date of birth',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    if (selectedNationality.value == 'Nationality') {
      Get.snackbar(
        'Error',
        'Please select your nationality',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    if (idDocument.value == null) {
      Get.snackbar(
        'Error',
        'Please upload your ID document',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    if (panDocument.value == null) {
      Get.snackbar(
        'Error',
        'Please upload your PAN document',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    if (!isChecked.value) {
      Get.snackbar(
        'Error',
        'Please confirm that your information is correct',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // Submit for verification
  void submitForVerification() {
    if (!validateForm()) {
      return;
    }

    // TODO: Implement actual KYC submission logic here
    Get.snackbar(
      'Success',
      'Your KYC documents have been submitted for verification',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    // Move to next step or navigate
    currentStep.value = 2;

    // After successful submission, you might want to navigate
    // Get.offAllNamed('/verification-pending');
  }

  // Navigate back
  void goBack() {
    Get.back();
  }

  // Change step (for multi-step form)
  void changeStep(int step) {
    currentStep.value = step;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    super.onClose();
  }
}
