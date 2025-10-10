import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/components/glass_button.dart';
import 'package:social_media/auth_controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF001D29), Color(0xFF0080B6), Color(0xFF84DAFE)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 220, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Sign up your Account',
                textAlign: TextAlign.center,
                style: AppFonts.primaryFont(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your personal data to create account',
                textAlign: TextAlign.center,
                style: AppFonts.primaryFont(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),

              /// Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GlassButton(
                        label: "Google",
                        imagePath: "assets/google-color-svgrepo-com.svg",
                        onTap: controller.signUpWithGoogle,
                      ),
                      const SizedBox(width: 30),
                      GlassButton(
                        label: "Facebook",
                        imagePath: "assets/facebook-svgrepo-com.svg",
                        onTap: controller.signUpWithFacebook,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Divider
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Or",
                        style: AppFonts.primaryFont(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// First + Last Name
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _glassTextField(
                            label: "First Name",
                            hint: "Ajmal",
                            controller: controller.firstNameController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _glassTextField(
                            label: "Last Name",
                            hint: "Khan",
                            controller: controller.lastNameController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Email + Phone
                    Row(
                      children: [
                        Expanded(
                          child: _glassTextField(
                            label: "Email",
                            hint: "lorem.ipsum@gmail.com",
                            controller: controller.emailController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _glassTextField(
                            label: "Phone Number",
                            hint: "0000000000",
                            controller: controller.phoneController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Password + Confirm Password
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => _glassTextField(
                              label: "Password",
                              hint: "",
                              controller: controller.passwordController,
                              obscureText: controller.obscurePassword.value,
                              toggle: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(
                            () => _glassTextField(
                              label: "Confirm Password",
                              hint: "",
                              controller: controller.confirmPasswordController,
                              obscureText:
                                  controller.obscureConfirmPassword.value,
                              toggle:
                                  controller.toggleConfirmPasswordVisibility,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Reference Number
                    _glassTextField(
                      label: "Reference Number",
                      hint: "#########",
                      controller: controller.referenceController,
                    ),

                    const SizedBox(height: 32),

                    GestureDetector(
                      onTap: controller.signUp,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 47, right: 47),
                        child: Container(
                          height: 30,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                    width: 1,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.15),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: AppFonts.primaryFont(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: AppFonts.primaryFont(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.navigateToLogin,
                    child: Text(
                      "Log in",
                      style: AppFonts.primaryFont(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    VoidCallback? toggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.primaryFont(color: Colors.white, fontSize: 10),
        ),
        const SizedBox(height: 6),

        // Use GlassContainer here 👇
        GlassContainer(
          height: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: AppFonts.primaryFont(color: Colors.white, fontSize: 10),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppFonts.primaryFont(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                suffixIcon: toggle != null
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          size: 15,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        onPressed: toggle,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    : null,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
