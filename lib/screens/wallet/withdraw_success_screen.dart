import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/screens/wallet/transaction_summery_screen.dart';

class WithdrawalController extends GetxController {
  final amount = 1000.00.obs;
  final userName = 'John Samuel K S'.obs;
  final userEmail = 'samuel@did'.obs;
  final transactionDate = '11 October 2025 4:30 PM'.obs;
}

class WithdrawalSuccessScreen extends StatefulWidget {
  WithdrawalSuccessScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalSuccessScreen> createState() =>
      _WithdrawalSuccessScreenState();
}

class _WithdrawalSuccessScreenState extends State<WithdrawalSuccessScreen> {
  final WithdrawalController controller = Get.put(WithdrawalController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => TransactionSummaryScreen());
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
                const Spacer(flex: 2),

                SizedBox(
                  height: 113,
                  width: 200,
                  child: Lottie.asset('assets/verified.json', repeat: true),
                ),

                const SizedBox(height: 13),

                Obx(
                  () => Text(
                    '\$${controller.amount.value.toStringAsFixed(2)}',
                    style: AppFonts.primaryFont(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Withdrawal Successful',
                  style: AppFonts.primaryFont(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50),
                  ),
                ),

                const SizedBox(height: 10),

                // User Details
                Obx(
                  () => Column(
                    children: [
                      Text(
                        controller.userName.value,
                        style: AppFonts.primaryFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.userEmail.value,
                        style: AppFonts.primaryFont(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.transactionDate.value,
                        style: AppFonts.primaryFont(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                Column(
                  children: [
                    Text(
                      'Your transaction is protected and being processed safely',
                      textAlign: TextAlign.center,
                      style: AppFonts.primaryFont(
                        fontSize: 12,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sit back while we handle the rest',
                      textAlign: TextAlign.center,
                      style: AppFonts.primaryFont(
                        fontSize: 12,
                        color: Color(0xFF66BB6A),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
