import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_media/auth_controller/new_password_controller.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/l10n/app_localizations.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  final controller = Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: controller.goBack,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.onboard_new_password,
                  style: AppFonts.primaryFont(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboard_enter_new_password,
                    style: AppFonts.primaryFont(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Container(
                      width: 304,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: controller.newPasswordController,
                        obscureText: !controller.isNewPasswordVisible.value,
                        style: AppFonts.primaryFont(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        decoration: InputDecoration(
                          hintText: 'At least 8 characters',
                          hintStyle: AppFonts.primaryFont(
                            color: Colors.grey[400],
                            fontSize: 10,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isNewPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                              size: 15,
                            ),
                            onPressed: controller.toggleNewPasswordVisibility,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF94C21A)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.onboard_confirm_password,
                    style: AppFonts.primaryFont(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Container(
                      width: 304,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        style: AppFonts.primaryFont(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          hintStyle: AppFonts.primaryFont(
                            color: Colors.grey[400],
                            fontSize: 10,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                              size: 15,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xFF94C21A)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF00A0E3),
                            ),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Obx(
                () => SizedBox(
                  width: 304,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00A0E3),
                      foregroundColor: Color(0xFF00A0E3),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.onboard_submit,
                            style: AppFonts.primaryFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
