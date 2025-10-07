import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class KYCController extends GetxController {
  final fullNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  final mobileNumberController = TextEditingController();
  final alternateMobileController = TextEditingController();

  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();

  final isChecked = false.obs;
  final currentStep = 1.obs;

  final selectedNationality = 'Nationality'.obs;
  final selectedGender = 'Gender'.obs;
  final selectedMaritalStatus = 'Marital Status'.obs;
  final selectedBloodGroup = 'Blood Group'.obs;
  final selectedState = 'State'.obs;
  final selectedCity = 'City'.obs;
  final selectedDistrict = 'District'.obs;
  final selectedPincode = 'Pin code'.obs;

  final selectedJobRole = 'Job Role'.obs;
  final selectedUserType = 'User Type'.obs;

  // Document files for ID verification screen
  final aadharFront = Rx<File?>(null);
  final aadharBack = Rx<File?>(null);
  final panFront = Rx<File?>(null);
  final panBack = Rx<File?>(null);
  final passbookFront = Rx<File?>(null);
  final passbookBack = Rx<File?>(null);
  final selfieImage = Rx<File?>(null);

  final List<String> nationalityOptions = [
    'Nationality',
    'Indian',
    'American',
    'British',
    'Canadian',
    'Australian',
    'German',
    'French',
    'Japanese',
    'Chinese',
    'Other',
  ];

  final List<String> genderOptions = ['Gender', 'Male', 'Female', 'Other'];

  final List<String> maritalStatusOptions = [
    'Marital Status',
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  final List<String> bloodGroupOptions = [
    'Blood Group',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  final List<String> stateOptions = [
    'State',
    'Kerala',
    'Tamil Nadu',
    'Karnataka',
    'Maharashtra',
    'Delhi',
    'Gujarat',
    'Rajasthan',
    'West Bengal',
    'Uttar Pradesh',
    'Other',
  ];

  final List<String> cityOptions = [
    'City',
    'Thiruvananthapuram',
    'Kochi',
    'Kozhikode',
    'Thrissur',
    'Kollam',
    'Kannur',
    'Palakkad',
    'Other',
  ];

  final List<String> districtOptions = [
    'District',
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
  ];

  final List<String> pincodeOptions = [
    'Pin code',
    '695001',
    '695002',
    '695003',
    '695004',
    '695005',
    '695006',
    '695007',
    '695008',
    '695009',
    '695010',
  ];

  final List<String> jobRoleOptions = [
    'Job Role',
    'Software Engineer',
    'Business Analyst',
    'Project Manager',
    'Designer',
    'Marketing Manager',
    'Sales Executive',
    'Teacher',
    'Doctor',
    'Entrepreneur',
    'Student',
    'Other',
  ];

  final List<String> userTypeOptions = [
    'User Type',
    'Individual',
    'Business',
    'Professional',
    'Enterprise',
  ];

  final ImagePicker _picker = ImagePicker();

  void changeNationality(String? value) {
    if (value != null) selectedNationality.value = value;
  }

  void changeGender(String? value) {
    if (value != null) selectedGender.value = value;
  }

  void changeMaritalStatus(String? value) {
    if (value != null) selectedMaritalStatus.value = value;
  }

  void changeBloodGroup(String? value) {
    if (value != null) selectedBloodGroup.value = value;
  }

  void changeState(String? value) {
    if (value != null) {
      selectedState.value = value;
      selectedCity.value = 'City';
    }
  }

  void changeCity(String? value) {
    if (value != null) selectedCity.value = value;
  }

  void changeDistrict(String? value) {
    if (value != null) selectedDistrict.value = value;
  }

  void changePincode(String? value) {
    if (value != null) selectedPincode.value = value;
  }

  void changeJobRole(String? value) {
    if (value != null) selectedJobRole.value = value;
  }

  void changeUserType(String? value) {
    if (value != null) selectedUserType.value = value;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
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

  // Document picker for ID verification
  Future<void> pickDocument(String documentType) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final File file = File(image.path);

        switch (documentType) {
          case 'aadhar_front':
            aadharFront.value = file;
            break;
          case 'aadhar_back':
            aadharBack.value = file;
            break;
          case 'pan_front':
            panFront.value = file;
            break;
          case 'pan_back':
            panBack.value = file;
            break;
          case 'passbook_front':
            passbookFront.value = file;
            break;
          case 'passbook_back':
            passbookBack.value = file;
            break;
          case 'selfie':
            selfieImage.value = file;
            break;
        }

        _showSuccess('Document uploaded successfully');
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  bool validateStep1() {
    if (fullNameController.text.trim().isEmpty) {
      _showError('Please enter your full name');
      return false;
    }

    if (selectedGender.value == 'Gender') {
      _showError('Please select your gender');
      return false;
    }

    if (selectedMaritalStatus.value == 'Marital Status') {
      _showError('Please select your marital status');
      return false;
    }

    if (selectedBloodGroup.value == 'Blood Group') {
      _showError('Please select your blood group');
      return false;
    }

    if (dateOfBirthController.text.trim().isEmpty) {
      _showError('Please select your date of birth');
      return false;
    }

    if (selectedState.value == 'State') {
      _showError('Please select your state');
      return false;
    }

    if (selectedCity.value == 'City') {
      _showError('Please select your city');
      return false;
    }

    if (selectedDistrict.value == 'District') {
      _showError('Please select your district');
      return false;
    }

    if (selectedPincode.value == 'Pin code') {
      _showError('Please select your pin code');
      return false;
    }

    if (selectedNationality.value == 'Nationality') {
      _showError('Please select your nationality');
      return false;
    }

    if (mobileNumberController.text.trim().isEmpty) {
      _showError('Please enter your mobile number');
      return false;
    }

    if (mobileNumberController.text.trim().length != 10) {
      _showError('Please enter a valid 10-digit mobile number');
      return false;
    }

    if (selectedJobRole.value == 'Job Role') {
      _showError('Please select your job role');
      return false;
    }

    if (selectedUserType.value == 'User Type') {
      _showError('Please select your user type');
      return false;
    }

    if (accountNameController.text.trim().isEmpty) {
      _showError('Please enter account holder name');
      return false;
    }

    if (accountNumberController.text.trim().isEmpty) {
      _showError('Please enter your account number');
      return false;
    }

    if (ifscCodeController.text.trim().isEmpty) {
      _showError('Please enter IFSC code');
      return false;
    }

    return true;
  }

  bool validateStep2() {
    if (aadharFront.value == null) {
      _showError('Please upload Aadhar card front');
      return false;
    }

    if (panFront.value == null) {
      _showError('Please upload PAN card front');
      return false;
    }

    if (passbookFront.value == null) {
      _showError('Please upload Pass Book front');
      return false;
    }

    if (selfieImage.value == null) {
      _showError('Please upload your selfie');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
    );
  }

  void goToNextStep() {
    if (currentStep.value == 1) {
      // Validate personal information
      if (!validateStep1()) {
        return;
      }

      // Change step with animation (no navigation)
      currentStep.value = 2;
      _showSuccess('Personal information saved successfully');
    } else if (currentStep.value == 2) {
      // Validate documents
      if (!validateStep2()) {
        return;
      }

      // Move to review step
      currentStep.value = 3;
      _showSuccess('Documents uploaded successfully');
    } else if (currentStep.value == 3) {
      // Submit KYC
      _showSuccess('KYC submitted successfully');
      // Add your submission logic here
    }
  }

  void goBack() {
    if (currentStep.value > 1) {
      // Go to previous step with animation
      currentStep.value--;
    } else {
      // Exit the KYC screen
      Get.back();
    }
  }

  void changeStep(int step) {
    currentStep.value = step;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    mobileNumberController.dispose();
    alternateMobileController.dispose();
    accountNameController.dispose();
    accountNumberController.dispose();
    ifscCodeController.dispose();
    super.onClose();
  }
}
