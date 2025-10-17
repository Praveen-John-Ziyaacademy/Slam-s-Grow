import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:social_media/auth_screen/login_screen.dart';
import 'package:social_media/components/bottom_bar.dart';

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
  final isSubmitting = false.obs;

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

  // Document files
  final aadharFront = Rx<File?>(null);
  final aadharBack = Rx<File?>(null);
  final panFront = Rx<File?>(null);
  final passbook_image = Rx<File?>(null);
  final selfieImage = Rx<File?>(null);

  final storage = GetStorage();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Verify token exists on initialization
    _verifyAuthToken();
  }

  // Verify auth token exists
  void _verifyAuthToken() {
    final token = storage.read('access');
    if (token == null || token.isEmpty) {
      Get.snackbar(
        'Authentication Required',
        'Please login again to continue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.7),
        colorText: Colors.white,
      );
      // Navigate to login after a delay
      Future.delayed(const Duration(seconds: 2), () {
        Get.to(() => LoginScreen());
      });
    } else {
      debugPrint('✓ Auth token found: ${token.substring(0, 20)}...');
    }
  }

  // Dropdown options lists
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
    'Promoter',
    'Client',
    'Admin',
    'Super Admin',
  ];

  // Change handlers
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

  // Date picker
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

  // Convert date format from DD/MM/YYYY to YYYY-MM-DD
  String _convertDateForAPI(String date) {
    try {
      final parts = date.split('/');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1]}-${parts[0]}';
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  // Document picker (Updated)
  Future<void> pickDocument(String documentType) async {
    try {
      final ImageSource source = documentType == 'selfie'
          ? ImageSource.camera
          : ImageSource.gallery;

      final XFile? image = await _picker.pickImage(
        source: source,
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
          case 'passbook_image':
            passbook_image.value = file;
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

  // Validation methods
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

    if (aadharBack.value == null) {
      _showError('Please upload Aadhar card back');
      return false;
    }

    if (panFront.value == null) {
      _showError('Please upload PAN card');
      return false;
    }

    if (passbook_image.value == null) {
      _showError('Please upload Pass Book');
      return false;
    }

    if (selfieImage.value == null) {
      _showError('Please upload your selfie');
      return false;
    }

    return true;
  }

  // Show messages
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

  Future<void> submitKYCToBackend() async {
    try {
      isSubmitting.value = true;

      final token = storage.read('access');
      if (token == null || token.isEmpty) {
        _showError('Authentication token missing. Please login again.');
        Get.to(() => LoginScreen());
        return;
      }

      debugPrint('📤 Submitting KYC with token: ${token.substring(0, 20)}...');

      final response = await KYCApiService.submitKYC(
        fullName: fullNameController.text.trim(),
        nationality: selectedNationality.value,
        gender: selectedGender.value,
        maritalStatus: selectedMaritalStatus.value,
        bloodGroup: selectedBloodGroup.value,
        dateOfBirth: _convertDateForAPI(dateOfBirthController.text),
        state: selectedState.value.toLowerCase(),
        city: selectedCity.value.toLowerCase(),
        district: selectedDistrict.value,
        pinCode: selectedPincode.value,
        mobileNumber: mobileNumberController.text.trim(),
        alternateMobile: alternateMobileController.text.trim(),
        jobRole: selectedJobRole.value,
        userType: selectedUserType.value.toLowerCase(),
        accountHolderName: accountNameController.text.trim(),
        accountNumber: accountNumberController.text.trim(),
        ifscCode: ifscCodeController.text.trim(),
        aadharFront: aadharFront.value!,
        aadharBack: aadharBack.value!,
        panFront: panFront.value!,
        passbook_image: passbook_image.value!,
        selfie: selfieImage.value!,
      );

      if (response['success']) {
        _showSuccess('KYC submitted successfully');
        storage.write('kyc_submitted', true);

        await Future.delayed(const Duration(seconds: 1));
        Get.to(() => HomePage());
      } else {
        _showError(response['message'] ?? 'Failed to submit KYC');

        if (response['message']?.toLowerCase().contains('login') == true ||
            response['message']?.toLowerCase().contains('unauthorized') ==
                true ||
            response['message']?.toLowerCase().contains('token') == true) {
          await Future.delayed(const Duration(seconds: 2));
          Get.to(() => LoginScreen());
        }
      }
    } catch (e) {
      _showError('Error submitting KYC: $e');
      debugPrint('❌ KYC Submission Error: $e');
    } finally {
      isSubmitting.value = false;
    }
  }

  void goToNextStep() {
    if (currentStep.value == 1) {
      if (!validateStep1()) return;
      currentStep.value = 2;
      _showSuccess('Personal information saved successfully');
    } else if (currentStep.value == 2) {
      if (!validateStep2()) return;
      currentStep.value = 3;
      _showSuccess('Documents uploaded successfully');
    } else if (currentStep.value == 3) {
      submitKYCToBackend();
    }
  }

  void goBack() {
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
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

class KYCApiService {
  static const String baseUrl = 'http://192.168.1.25:8000/api';

  static String? getAuthToken() {
    final storage = GetStorage();
    return storage.read('access');
  }

  static Future<Map<String, dynamic>> submitKYC({
    required String fullName,
    required String nationality,
    required String gender,
    required String maritalStatus,
    required String bloodGroup,
    required String dateOfBirth,
    required String state,
    required String city,
    required String district,
    required String pinCode,
    required String mobileNumber,
    required String alternateMobile,
    required String jobRole,
    required String userType,
    required String accountHolderName,
    required String accountNumber,
    required String ifscCode,
    required File aadharFront,
    required File aadharBack,
    required File panFront,
    required File passbook_image,
    required File selfie,
  }) async {
    try {
      final token = getAuthToken();

      if (token == null || token.isEmpty) {
        return {
          'success': false,
          'error': 'Authentication token not found',
          'message': 'Please login again',
        };
      }

      var uri = Uri.parse('$baseUrl/kyc/');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      debugPrint('🔐 Using access: ${token.substring(0, 20)}...');
      debugPrint('📍 Endpoint: $uri');

      request.fields['full_name'] = fullName;
      request.fields['nationality'] = nationality;
      request.fields['gender'] = gender;
      request.fields['marital_status'] = maritalStatus;
      request.fields['blood_group'] = bloodGroup;
      request.fields['date_of_birth'] = dateOfBirth;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['district'] = district;
      request.fields['pin_code'] = pinCode;
      request.fields['mobile_number'] = mobileNumber;
      request.fields['alternate_mobile_number'] = alternateMobile;

      request.fields['job_role'] = jobRole;
      request.fields['user_type'] = userType;
      request.fields['account_holder_name'] = accountHolderName;
      request.fields['account_number'] = accountNumber;
      request.fields['ifsc_code'] = ifscCode;

      request.files.add(
        await http.MultipartFile.fromPath('aadhar_front', aadharFront.path),
      );

      request.files.add(
        await http.MultipartFile.fromPath('aadhar_back', aadharBack.path),
      );

      request.files.add(
        await http.MultipartFile.fromPath('pan_front', panFront.path),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'passbook_image',
          passbook_image.path,
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath('selfie', selfie.path),
      );

      debugPrint('📦 Sending ${request.files.length} files');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint('📥 Response status: ${response.statusCode}');
      debugPrint('📥 Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'data': json.decode(response.body),
          'message': 'KYC submitted successfully',
        };
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'error': 'Unauthorized',
          'message': 'Session expired. Please login again',
        };
      } else {
        try {
          final errorData = json.decode(response.body);
          return {
            'success': false,
            'error': errorData,
            'message': errorData['message'] ?? 'Failed to submit KYC',
          };
        } catch (e) {
          return {
            'success': false,
            'error': response.body,
            'message': 'Failed to submit KYC: ${response.statusCode}',
          };
        }
      }
    } catch (e) {
      debugPrint('❌ Exception in submitKYC: $e');
      return {
        'success': false,
        'error': e.toString(),
        'message': 'An error occurred while submitting KYC',
      };
    }
  }

  static bool isAuthenticated() {
    final token = getAuthToken();
    return token != null && token.isNotEmpty;
  }

  static Map<String, dynamic> getUserInfo() {
    final storage = GetStorage();
    return {
      'id': storage.read('id'),
      'email': storage.read('user_email'),
      'name': storage.read('user_name'),
      'access': storage.read('access'),
    };
  }
}
