// View
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_media/colors/colors.dart';
import 'package:social_media/auth_controller/forgot_controller.dart';
import 'package:social_media/colors/fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: controller.goToSignIn,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Title
              Center(
                child: Text(
                  'Forgot Password',
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
                    'Enter Email Address',
                    style: AppFonts.primaryFont(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Text Field
                  Container(
                    width: 304,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: controller.emailController,
                      style: AppFonts.primaryFont(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                        hintStyle: AppFonts.primaryFont(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 10,
                        ),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Color(0xFF94C21A)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        if (controller.emailError.value != null) {
                          controller.clearEmailError();
                        }
                      },
                    ),
                  ),

                  // Error message outside the text box
                  Obx(
                    () => controller.emailError.value != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                            child: Text(
                              controller.emailError.value!,
                              style: AppFonts.primaryFont(
                                color: Colors.red,
                                fontSize: 11,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              // Back to sign in link
              Center(
                child: TextButton(
                  onPressed: controller.goToSignIn,
                  child: Text(
                    'Back to sign in',
                    style: AppFonts.primaryFont(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Get OTP button
              Obx(
                () => Container(
                  width: 304,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.getOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Get OTP',
                            style: AppFonts.primaryFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // OR divider
              Center(
                child: Text(
                  'or',
                  style: AppFonts.primaryFont(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    onPressed: controller.loginWithGoogle,
                    child: SvgPicture.asset(
                      'assets/google-color-svgrepo-com.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 30),
                  _SocialButton(
                    onPressed: controller.loginWithApple,
                    child: const Icon(
                      Icons.apple,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 30),
                  _SocialButton(
                    onPressed: controller.loginWithFacebook,
                    child: SvgPicture.asset(
                      'assets/facebook-svgrepo-com.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              Column(
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppFonts.primaryFont(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 304,
                    height: 30,
                    child: OutlinedButton(
                      onPressed: controller.goToSignUp,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF94C21A),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Sign up',
                        style: AppFonts.primaryFont(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const _SocialButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Center(child: child),
      ),
    );
  }
}
