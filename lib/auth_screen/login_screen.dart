import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/colors/fonts.dart';
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

                const SizedBox(height: 28),
                Text(
                  'Login to Continue',
                  textAlign: TextAlign.center,
                  style: AppFonts.primaryFont(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlassButton(
                      label: "Google",
                      imagePath: "assets/google-color-svgrepo-com.svg",
                      onTap: controller.loginWithGoogle,
                    ),
                    const SizedBox(width: 56),
                    GlassButton(
                      label: "Facebook",
                      imagePath: "assets/facebook-svgrepo-com.svg",
                      onTap: controller.loginWithFacebook,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.black)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Or',
                          style: AppFonts.primaryFont(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.black)),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: AppFonts.primaryFont(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Email Input
                      GlassContainer(
                        height: 30,
                        width: double.infinity,
                        child: TextField(
                          controller: controller.emailController,
                          style: AppFonts.primaryFont(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'lorem.ipsum@gmail.com',
                            hintStyle: AppFonts.primaryFont(
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
                            contentPadding: const EdgeInsets.only(top: 8),
                            isDense: true,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Password Input
                      Text(
                        'Password',
                        style: AppFonts.primaryFont(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => GlassContainer(
                          height: 30,
                          width: double.infinity,
                          child: TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            style: AppFonts.primaryFont(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: Colors.transparent,
                              hintText: '********',
                              hintStyle: AppFonts.primaryFont(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10,
                              ),

                              prefixIcon: const Icon(
                                Icons.shield_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                              prefixIconConstraints: const BoxConstraints(
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
                                onPressed: controller.togglePasswordVisibility,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 35,
                                minHeight: 30,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 8),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Row(
                                children: [
                                  Text(
                                    'Remember me',
                                    style: AppFonts.primaryFont(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Checkbox(
                                      value: controller.rememberMe.value,
                                      onChanged: controller.toggleRememberMe,
                                      fillColor: MaterialStateProperty.all(
                                        Colors.white.withOpacity(0.3),
                                      ),
                                      checkColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity(
                                        horizontal: -4,
                                        vertical: -4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: controller.forgotPassword,
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Forgot password?',

                                      style: AppFonts.primaryFont(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Container(
                                      height: 1,
                                      color: Colors.white,
                                      width: 73,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                GestureDetector(
                  onTap: controller.login,
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
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.15),
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: AppFonts.primaryFont(
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
                    Text(
                      'Don\'t have an account? ',
                      style: AppFonts.primaryFont(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.navigateToSignUp,
                      child: Text(
                        'Sign Up',
                        style: AppFonts.primaryFont(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'By continuing you agree that you have read and accepted our T&C and privacy policy',
                    textAlign: TextAlign.center,
                    style: AppFonts.primaryFont(
                      color: Colors.white,
                      fontSize: 12,
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
