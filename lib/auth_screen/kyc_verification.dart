import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social_media/auth_controller/kyc_controller.dart';
import 'package:social_media/colors/colors.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/l10n/app_localizations.dart';

class KYCVerificationScreen extends StatelessWidget {
  const KYCVerificationScreen({super.key});

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
                    children: [
                      Icon(Icons.lock_outline, size: 14, color: Colors.black54),
                      SizedBox(width: 6),
                      Text(
                        AppLocalizations.of(context)!.onboard_kyc_title,
                        style: AppFonts.primaryFont(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.onboard_kyc_subtitle,
                    style: AppFonts.primaryFont(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Column(
                      children: [
                        // Lines and circles layer
                        SizedBox(
                          height: 24,
                          child: Row(
                            children: [
                              _buildCircleWithLines(
                                1,
                                controller.currentStep.value >= 1,
                                controller.currentStep.value > 1,
                                showLeftLine: false,
                                showRightLine: true,
                                rightLineActive:
                                    controller.currentStep.value > 1,
                              ),
                              _buildCircleWithLines(
                                2,
                                controller.currentStep.value >= 2,
                                controller.currentStep.value > 2,
                                showLeftLine: true,
                                showRightLine: true,
                                leftLineActive:
                                    controller.currentStep.value > 1,
                                rightLineActive:
                                    controller.currentStep.value > 2,
                              ),
                              _buildCircleWithLines(
                                3,
                                controller.currentStep.value >= 3,
                                controller.currentStep.value > 3,
                                showLeftLine: true,
                                showRightLine: false,
                                leftLineActive:
                                    controller.currentStep.value > 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Labels layer
                        Row(
                          children: [
                            _buildStepLabel(
                              AppLocalizations.of(
                                context,
                              )!.onboard_personal_info,
                              controller.currentStep.value >= 1,
                            ),
                            _buildStepLabel(
                              AppLocalizations.of(
                                context,
                              )!.onboard_id_verification,
                              controller.currentStep.value >= 2,
                            ),
                            _buildStepLabel(
                              AppLocalizations.of(
                                context,
                              )!.onboard_review_submit,
                              controller.currentStep.value >= 3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // Animated content section
            Expanded(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        final offsetAnimation =
                            Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            );

                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                  child: _buildStepContent(controller, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(KYCController controller, BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return _buildPersonalInfoStep(controller, context);
      case 2:
        return _buildIDVerificationStep(controller, context);
      case 3:
        return _buildReviewSubmitStep(controller, context);
      default:
        return _buildPersonalInfoStep(controller, context);
    }
  }

  Widget _buildPersonalInfoStep(KYCController controller, context) {
    return SingleChildScrollView(
      key: const ValueKey(1),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            AppLocalizations.of(context)!.onboard_personal_information,
            style: AppFonts.primaryFont(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            AppLocalizations.of(context)!.onboard_full_name,
            controller.fullNameController,
            'Enter your full name',
          ),
          const SizedBox(height: 18),
          _buildDropdownField(
            AppLocalizations.of(context)!.onboard_nationality,
            controller.selectedNationality,
            controller.nationalityOptions,
            controller.changeNationality,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  AppLocalizations.of(context)!.onboard_gender,
                  controller.selectedGender,
                  controller.genderOptions,
                  controller.changeGender,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  AppLocalizations.of(context)!.onboard_marital_status,
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
                  AppLocalizations.of(context)!.onboard_blood_group,
                  controller.selectedBloodGroup,
                  controller.bloodGroupOptions,
                  controller.changeBloodGroup,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDateField(
                  AppLocalizations.of(context)!.onboard_date_of_birth,
                  controller.dateOfBirthController,
                  () => controller.pickDateOfBirth(Get.context!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  AppLocalizations.of(context)!.onboard_state,
                  controller.selectedState,
                  controller.stateOptions,
                  controller.changeState,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  AppLocalizations.of(context)!.onboard_city,
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
                  AppLocalizations.of(context)!.onboard_district,
                  controller.selectedDistrict,
                  controller.districtOptions,
                  controller.changeDistrict,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  AppLocalizations.of(context)!.onboard_pin_code,
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
                  AppLocalizations.of(context)!.onboard_mobile_number,
                  controller.mobileNumberController,
                  'Enter mobile number',
                  width: double.infinity,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  AppLocalizations.of(context)!.onboard_another_mobile_number,
                  controller.alternateMobileController,
                  'Enter alternate number',
                  width: double.infinity,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.onboard_professional_details,
            style: AppFonts.primaryFont(
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
                  AppLocalizations.of(context)!.onboard_job_role,
                  controller.selectedJobRole,
                  controller.jobRoleOptions,
                  controller.changeJobRole,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  AppLocalizations.of(context)!.onboard_user_type,
                  controller.selectedUserType,
                  controller.userTypeOptions,
                  controller.changeUserType,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.onboard_account_details,
            style: AppFonts.primaryFont(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            AppLocalizations.of(context)!.onboard_full_name,
            controller.accountNameController,
            'Enter account holder name',
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  AppLocalizations.of(context)!.onboard_account_number,
                  controller.accountNumberController,
                  'Enter account number',
                  width: double.infinity,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  AppLocalizations.of(context)!.onboard_ifsc_code,
                  controller.ifscCodeController,
                  'Enter IFSC code',
                  width: double.infinity,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 304,
              height: 30,
              child: ElevatedButton(
                onPressed: controller.goToNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.onboard_next,
                  style: AppFonts.primaryFont(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIDVerificationStep(KYCController controller, context) {
    return SingleChildScrollView(
      key: const ValueKey(2),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            AppLocalizations.of(context)!.onboard_upload_documents,
            style: AppFonts.primaryFont(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          _buildDocumentUploadDouble(
            AppLocalizations.of(context)!.onboard_aadhar_card,
            'assets/aadhar card.svg',
            controller.aadharFront,
            controller.aadharBack,
            () => controller.pickDocument('aadhar_front'),
            () => controller.pickDocument('aadhar_back'),
            context,
          ),
          const SizedBox(height: 20),

          _buildDocumentUploadSingle(
            AppLocalizations.of(context)!.onboard_pan_card,
            'assets/pan card.svg',
            controller.panFront,
            () => controller.pickDocument('pan_front'),
          ),
          const SizedBox(height: 20),

          // Pass Book - Front Only
          _buildDocumentUploadSingle(
            AppLocalizations.of(context)!.onboard_pass_book,
            'assets/pass book.svg',
            controller.passbook_image,
            () => controller.pickDocument('passbook_image'),
          ),

          const SizedBox(height: 20),

          // Selfie
          _buildSelfieUpload(
            AppLocalizations.of(context)!.onboard_selfie,
            controller.selfieImage,
            () => controller.pickDocument('selfie'),
          ),

          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 304,
              height: 30,
              child: ElevatedButton(
                onPressed: controller.goToNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.onboard_next,
                  style: AppFonts.primaryFont(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadDouble(
    String title,
    String svgPath,
    Rx<File?> frontImage,
    Rx<File?> backImage,
    VoidCallback onFrontTap,
    VoidCallback onBackTap,
    BuildContext context,
  ) {
    return Obx(() {
      bool hasFront = frontImage.value != null;
      bool hasBack = backImage.value != null;

      if (hasFront && hasBack) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onFrontTap,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          frontImage.value!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onBackTap,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          backImage.value!,
                          fit: BoxFit.cover,
                          width: double.infinity,
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

      if (hasFront && !hasBack) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onFrontTap,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          frontImage.value!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onBackTap,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.onboard_upload_back,
                            style: AppFonts.primaryFont(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }

      return GestureDetector(
        onTap: onFrontTap,
        child: Center(
          child: Container(
            height: 120,
            width: 319,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.primaryFont(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          svgPath,
                          height: 65,
                          width: 85,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Click or Drag & Drop to upload',
                                textAlign: TextAlign.center,
                                style: AppFonts.primaryFont(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'PNG, JPG • Max X MB',
                                textAlign: TextAlign.center,
                                style: AppFonts.primaryFont(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '(Front & Back)',
                                textAlign: TextAlign.center,
                                style: AppFonts.primaryFont(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDocumentUploadSingle(
    String title,
    String svgPath,
    Rx<File?> frontImage,
    VoidCallback onTap,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            height: 120,
            width: 319,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: frontImage.value == null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFonts.primaryFont(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                svgPath,
                                height: 65,
                                width: 85,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Click or Drag & Drop to upload',
                                      textAlign: TextAlign.center,
                                      style: AppFonts.primaryFont(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'PNG, JPG • Max X MB',
                                      textAlign: TextAlign.center,
                                      style: AppFonts.primaryFont(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      frontImage.value!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewSubmitStep(KYCController controller, context) {
    return SingleChildScrollView(
      key: const ValueKey(3),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            AppLocalizations.of(context)!.onboard_personal_information,
            style: AppFonts.primaryFont(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Personal Information Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildReviewRow(
                  'Full Name :',
                  controller.fullNameController.text,
                ),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Date of Birth :',
                  controller.dateOfBirthController.text,
                ),
                const SizedBox(height: 12),
                _buildReviewRow('Gender :', controller.selectedGender.value),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Blood Group :',
                  controller.selectedBloodGroup.value,
                ),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Marital Status :',
                  controller.selectedMaritalStatus.value,
                ),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Nationality :',
                  controller.selectedNationality.value,
                ),
                const SizedBox(height: 12),
                _buildReviewRow('State :', controller.selectedState.value),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'District :',
                  controller.selectedDistrict.value,
                ),
                const SizedBox(height: 12),
                _buildReviewRow('City :', controller.selectedCity.value),
                const SizedBox(height: 12),
                _buildReviewRow('Pin code :', controller.selectedPincode.value),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Mobile Number :',
                  controller.mobileNumberController.text,
                ),
                if (controller.alternateMobileController.text.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildReviewRow(
                    'Another Mobile Number :',
                    controller.alternateMobileController.text,
                  ),
                ],
                const SizedBox(height: 12),
                _buildReviewRow('Job Role :', controller.selectedJobRole.value),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'User Type :',
                  controller.selectedUserType.value,
                ),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Account Holder\'s Name :',
                  controller.accountNameController.text,
                ),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'Account Number :',
                  controller.accountNumberController.text,
                ),
                const SizedBox(height: 12),
                _buildReviewRow(
                  'IFSC Code :',
                  controller.ifscCodeController.text,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.onboard_upload_documents,
            style: AppFonts.primaryFont(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Documents Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildDocumentPreview(
                  AppLocalizations.of(context)!.onboard_aadhar_card,
                  controller.aadharFront.value,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDocumentPreview(
                  AppLocalizations.of(context)!.onboard_pan_card,
                  controller.panFront.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildDocumentPreview(
                  AppLocalizations.of(context)!.onboard_pass_book,
                  controller.passbook_image.value,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDocumentPreview(
                  AppLocalizations.of(context)!.onboard_selfie,
                  controller.selfieImage.value,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Checkboxes
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: controller.isChecked.value,
                    onChanged: controller.toggleCheckbox,
                    activeColor: AppColors.primary,
                    side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.onboard_confirm_information,
                    style: AppFonts.primaryFont(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  value: true,
                  onChanged: (value) {},
                  activeColor: AppColors.primary,
                  side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.onboard_agree_terms,
                  style: AppFonts.primaryFont(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 304,
              height: 30,
              child: ElevatedButton(
                onPressed: controller.goToNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.onboard_submit,
                  style: AppFonts.primaryFont(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.primaryFont(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppFonts.primaryFont(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentPreview(String title, File? image) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: image != null
                  ? Image.file(image, fit: BoxFit.cover, width: double.infinity)
                  : Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image, color: Colors.grey, size: 32),
                      ),
                    ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppFonts.primaryFont(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleWithLines(
    int number,
    bool isActive,
    bool isCompleted, {
    required bool showLeftLine,
    required bool showRightLine,
    bool leftLineActive = false,
    bool rightLineActive = false,
  }) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: showLeftLine
                      ? (leftLineActive
                            ? const Color(0xFF00A0E3)
                            : Colors.grey[300])
                      : Colors.transparent,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Container(
                  height: 2,
                  color: showRightLine
                      ? (rightLineActive
                            ? const Color(0xFF00A0E3)
                            : Colors.grey[300])
                      : Colors.transparent,
                ),
              ),
            ],
          ),
          _buildCircle(number, isActive, isCompleted),
        ],
      ),
    );
  }

  Widget _buildStepLabel(String label, bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.primaryFont(
            fontSize: 11,
            color: isActive ? Colors.black87 : Colors.grey[500],
            fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
            height: 1.3,
          ),
        ),
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
                style: AppFonts.primaryFont(
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
    String hint, {
    double width = double.infinity,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.primaryFont(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 30,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: TextField(
            controller: controller,
            style: AppFonts.primaryFont(fontSize: 12),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: hint,
              hintStyle: AppFonts.primaryFont(
                color: Colors.grey[600],
                fontSize: 10,
              ),
              contentPadding: const EdgeInsets.only(left: 8, top: 5),
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
          style: AppFonts.primaryFont(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            height: 30,
            width: double.infinity,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: AppFonts.primaryFont(
                        color: value == options.first
                            ? Colors.grey[600]
                            : Colors.black,
                        fontSize: 12,
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
          style: AppFonts.primaryFont(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: TextField(
              controller: controller,
              enabled: false,
              style: AppFonts.primaryFont(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: 'DD/MM/YYYY',
                hintStyle: AppFonts.primaryFont(
                  color: Colors.grey[600],
                  fontSize: 10,
                ),
                contentPadding: const EdgeInsets.only(left: 8, top: 5),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelfieUpload(
    String title,
    Rx<File?> selfieImage,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 120,
          width: 319,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(
            () => selfieImage.value == null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFonts.primaryFont(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/selfie.svg',
                                height: 70,
                                width: 70,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Spot Selfie',
                                    textAlign: TextAlign.center,
                                    style: AppFonts.primaryFont(
                                      fontSize: 13,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      selfieImage.value!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
