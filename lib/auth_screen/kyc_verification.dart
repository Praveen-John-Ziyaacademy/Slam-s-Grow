import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_controller/kyc_controller.dart';

class KYCVerificationScreen extends StatelessWidget {
  const KYCVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final KYCController controller = Get.put(KYCController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 20),
                        onPressed: controller.goBack,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.lock_outline, size: 14, color: Colors.black54),
                      SizedBox(width: 6),
                      Text(
                        'KYC Verification',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your information is securely stored & encrypted',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Row(
                      children: [
                        _buildStepWithConnector(
                          1,
                          'Personal info',
                          controller.currentStep.value >= 1,
                          controller.currentStep.value > 1,
                          controller.currentStep.value > 1,
                        ),
                        _buildStepWithConnector(
                          2,
                          'ID Verification',
                          controller.currentStep.value >= 2,
                          controller.currentStep.value > 2,
                          controller.currentStep.value > 2,
                        ),
                        _buildStepWithConnector(
                          3,
                          'Review & Submit',
                          controller.currentStep.value >= 3,
                          controller.currentStep.value > 3,
                          false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            'Full Name',
                            controller.fullNameController,
                            'Enter your full name',
                          ),
                          const SizedBox(height: 18),
                          _buildDropdownField(
                            'Nationality',
                            controller.selectedNationality,
                            controller.nationalityOptions,
                            controller.changeNationality,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdownField(
                                  'Gender',
                                  controller.selectedGender,
                                  controller.genderOptions,
                                  controller.changeGender,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  'Marital Status',
                                  controller.selectedMaritalStatus,
                                  controller.maritalStatusOptions,
                                  controller.changeMaritalStatus,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdownField(
                                  'Blood Group',
                                  controller.selectedBloodGroup,
                                  controller.bloodGroupOptions,
                                  controller.changeBloodGroup,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDateField(
                                  'Date of Birth',
                                  controller.dateOfBirthController,
                                  () => controller.pickDateOfBirth(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdownField(
                                  'State',
                                  controller.selectedState,
                                  controller.stateOptions,
                                  controller.changeState,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  'City',
                                  controller.selectedCity,
                                  controller.cityOptions,
                                  controller.changeCity,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdownField(
                                  'District',
                                  controller.selectedDistrict,
                                  controller.districtOptions,
                                  controller.changeDistrict,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  'Pin code',
                                  controller.selectedPincode,
                                  controller.pincodeOptions,
                                  controller.changePincode,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  'Mobile Number',
                                  controller.mobileNumberController,
                                  'Enter mobile number',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  'Another Mobile Number',
                                  controller.alternateMobileController,
                                  'Enter alternate number',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Professional Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdownField(
                                  'Job Role',
                                  controller.selectedJobRole,
                                  controller.jobRoleOptions,
                                  controller.changeJobRole,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  'User Type',
                                  controller.selectedUserType,
                                  controller.userTypeOptions,
                                  controller.changeUserType,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Account Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            'Full Name',
                            controller.accountNameController,
                            'Enter account holder name',
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  'Account Number',
                                  controller.accountNumberController,
                                  'Enter account number',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  'IFSC Code',
                                  controller.ifscCodeController,
                                  'Enter IFSC code',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: controller.goToNextStep,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00BCD4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepWithConnector(
    int number,
    String label,
    bool isActive,
    bool isCompleted,
    bool isNextActive,
  ) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      color: number == 1
                          ? Colors.transparent
                          : (isActive
                                ? const Color(0xFF00A0E3)
                                : Colors.grey[300]),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: number == 3
                          ? Colors.transparent
                          : (isNextActive
                                ? const Color(0xFF00A0E3)
                                : Colors.grey[300]),
                    ),
                  ),
                ],
              ),

              _buildCircle(number, isActive, isCompleted),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? Colors.black87 : Colors.grey[500],
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(int number, bool isActive, bool isCompleted) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00A0E3) : Colors.white,
        border: Border.all(
          color: isActive ? const Color(0xFF00A0E3) : Colors.grey[300]!,
          width: 1.5,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : Text(
                '$number',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    RxString selectedValue,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue.value,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 20,
                ),
                items: options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: value == options.first
                            ? Colors.grey[600]
                            : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(
    String label,
    TextEditingController controller,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: TextField(
              controller: controller,
              enabled: false,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                hintText: 'DD/MM/YYYY',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
