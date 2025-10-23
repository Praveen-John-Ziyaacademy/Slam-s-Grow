import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/components/bottom_bar.dart';

class KycSuccessScreen extends StatefulWidget {
  KycSuccessScreen({Key? key}) : super(key: key);

  @override
  State<KycSuccessScreen> createState() => _KycSuccessScreenState();
}

class _KycSuccessScreenState extends State<KycSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(() => HomePage());
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
                  height: 113,
                  width: 200,
                  child: Lottie.asset('assets/verification.json', repeat: true),
                ),

                const SizedBox(height: 13),

                Text(
                  'KYC Verification',
                  style: AppFonts.primaryFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Text(
                  'Successful',
                  style: AppFonts.primaryFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
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
