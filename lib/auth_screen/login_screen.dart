import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/components/glass_button.dart';

import 'package:social_media/auth_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF001D29),
                  Color(0xFF0080B6),
                  Color(0xFF84DAFE),
                ],
              ),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/2815.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // 📝 Login Form (fills remaining space)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: screenHeight * 0.7,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 24),
                              const Text(
                                'Login to Continue',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Social Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GlassButton(
                                        label: "Google",
                                        imagePath:
                                            "assets/google-color-svgrepo-com.svg",
                                        onTap: controller.loginWithGoogle,
                                      ),
                                      const SizedBox(width: 30),
                                      GlassButton(
                                        label: "Facebook",
                                        imagePath:
                                            "assets/facebook-svgrepo-com.svg",
                                        onTap: controller.loginWithFacebook,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      'Or',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Email Input
                              const Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Email Input
                              GlassContainer(
                                height: 30,
                                width: 240,
                                child: TextField(
                                  controller: controller.emailController,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: 'lorem.ipsum@gmail.com',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 10,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 35,
                                      minHeight: 30,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(
                                      top: 8,
                                    ),
                                    isDense: true,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Password Input
                              const Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => GlassContainer(
                                  height: 30,
                                  width: 240,
                                  child: TextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                        controller.obscurePassword.value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),

                                    decoration: InputDecoration(
                                      filled: false,
                                      fillColor: Colors.transparent,
                                      hintText: '********',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 10,
                                      ),

                                      prefixIcon: const Icon(
                                        Icons.shield_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                            minWidth: 35,
                                            minHeight: 30,
                                          ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.obscurePassword.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 15,
                                        ),
                                        onPressed:
                                            controller.togglePasswordVisibility,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
                                            minWidth: 35,
                                            minHeight: 30,
                                          ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        top: 8,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Row(
                                        children: [
                                          const Text(
                                            'Remember me',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: 0.7,
                                            child: Checkbox(
                                              value:
                                                  controller.rememberMe.value,
                                              onChanged:
                                                  controller.toggleRememberMe,
                                              fillColor:
                                                  MaterialStateProperty.all(
                                                    Colors.white.withOpacity(
                                                      0.3,
                                                    ),
                                                  ),
                                              checkColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.white.withOpacity(
                                                  0.5,
                                                ),
                                              ),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity: VisualDensity(
                                                horizontal: -4,
                                                vertical: -4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: 1),
                                        Container(
                                          height: 1,
                                          color: Colors.white,
                                          width: 85,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              GestureDetector(
                                onTap: controller.login,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 47,
                                    right: 47,
                                  ),
                                  child: Container(
                                    height: 30,
                                    width: 240,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 10,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(
                                                0.25,
                                              ),
                                              width: 1,
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.white.withOpacity(0.15),
                                                Colors.white.withOpacity(0.0),
                                              ],
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account? ',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: controller.navigateToSignUp,
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 34),
                              const Text(
                                'By continuing you agree that you have read and accepted our T&C and privacy policy',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
