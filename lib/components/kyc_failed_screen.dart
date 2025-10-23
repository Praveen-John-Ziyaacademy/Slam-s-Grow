import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/auth_screen/kyc_verification.dart';
import 'package:social_media/colors/fonts.dart';

class KycFailedScreen extends StatefulWidget {
  KycFailedScreen({super.key});

  @override
  State<KycFailedScreen> createState() => _KycFailedScreenState();
}

class _KycFailedScreenState extends State<KycFailedScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(() => KYCVerificationScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 200),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                    'assets/Error animation.json',
                    repeat: true,
                  ),
                ),

                Text(
                  'KYC Verification',
                  style: AppFonts.primaryFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Failed',
                  style: AppFonts.primaryFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
