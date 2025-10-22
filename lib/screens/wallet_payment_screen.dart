import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/colors/colors.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/controller/wallet_payment_controller.dart';
import 'package:social_media/screens/wallet/wallet_payment_method_screen.dart';

class WalletPaymentsScreen extends StatefulWidget {
  const WalletPaymentsScreen({super.key});

  @override
  State<WalletPaymentsScreen> createState() => _WalletPaymentsScreenState();
}

class _WalletPaymentsScreenState extends State<WalletPaymentsScreen> {
  final WalletPaymentsScreenController controller = Get.put(
    WalletPaymentsScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Withdraw Funds",
          style: AppFonts.primaryFont(fontSize: 16),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF206DFF).withOpacity(0.12),
                    Color(0xFF319F43).withOpacity(0.12),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFF319F43), width: 0.3),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Balance",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF319F43),

                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => Text(
                            "₹${controller.balance.value.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              color: AppColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "This week",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF319F43),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "+₹250",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF319F43),

                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Amount",
                    style: AppFonts.primaryFont(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF206DFF).withOpacity(0.12),
                          Color(0xFF319F43).withOpacity(0.12),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: InputBorder.none,
                        hintText: "Enter amount",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Minimum Withdrawal; ₹ 100.00",
                    style: AppFonts.primaryFont(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.only(left: 27, right: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Select",
                    style: AppFonts.primaryFont(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6FFFD),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 0.3,
                              color: Color(0xFF8CEEB9),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "₹ 100",
                              style: AppFonts.primaryFont(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6FFFD),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 0.3,
                              color: Color(0xFF8CEEB9),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "₹ 100",
                              style: AppFonts.primaryFont(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6FFFD),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 0.3,
                              color: Color(0xFF8CEEB9),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "₹ 100",
                              style: AppFonts.primaryFont(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => PaymentMethodScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Color(0xFF206DFF), Color(0xFF319F43)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Continue",
                        style: AppFonts.primaryFont(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
