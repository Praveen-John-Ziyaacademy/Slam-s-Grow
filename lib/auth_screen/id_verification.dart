import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_controller/kyc_controller.dart';

class IDVerificationScreen extends StatelessWidget {
  const IDVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final KYCController controller = Get.find<KYCController>();

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
                          'Review&Submit',
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
                    const Text(
                      'Upload Documents',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDocumentUpload(
                      'Aadhar Card',
                      Icons.credit_card_outlined,
                      controller.aadharFront,
                      controller.aadharBack,
                      () => controller.pickDocument('aadhar_front'),
                      () => controller.pickDocument('aadhar_back'),
                    ),
                    const SizedBox(height: 20),
                    _buildDocumentUpload(
                      'Pan Card',
                      Icons.credit_card_outlined,
                      controller.panFront,
                      controller.panBack,
                      () => controller.pickDocument('pan_front'),
                      () => controller.pickDocument('pan_back'),
                    ),
                    const SizedBox(height: 20),
                    _buildDocumentUpload(
                      'Pass Book',
                      Icons.menu_book_outlined,
                      controller.passbookFront,
                      controller.passbookBack,
                      () => controller.pickDocument('passbook_front'),
                      () => controller.pickDocument('passbook_back'),
                    ),
                    const SizedBox(height: 20),
                    _buildSelfieUpload(
                      'Selfie',
                      controller.selfieImage,
                      () => controller.pickDocument('selfie'),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.goToNextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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

  Widget _buildDocumentUpload(
    String title,
    IconData icon,
    Rx<File?> frontImage,
    Rx<File?> backImage,
    VoidCallback onFrontTap,
    VoidCallback onBackTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => GestureDetector(
                  onTap: onFrontTap,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),

                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: frontImage.value == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, size: 32, color: Colors.blue[300]),
                              const SizedBox(height: 8),
                              Text(
                                'click or Drag & drop to up-',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'load PNG,JPG,X MB',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '(Front & Back)',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              frontImage.value!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelfieUpload(
    String title,
    Rx<File?> selfieImage,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),

                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: selfieImage.value == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 32,
                          color: Colors.blue[300],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Spot Selfie',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(selfieImage.value!, fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
