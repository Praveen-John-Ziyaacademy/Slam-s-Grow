import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/screens/home/wallet_screen.dart';

class TransactionController extends GetxController {
  final withdrawalAmount = 1000.00.obs;
  final processingFee = 10.00.obs;
  final paymentMethod = 'UPI'.obs;
  final account = 'user@icici'.obs;

  double get totalAmount => withdrawalAmount.value - processingFee.value;
}

class TransactionSummaryScreen extends StatelessWidget {
  const TransactionSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: const Text('', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF206DFF), Color(0xFF319F43)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Transform.rotate(
                  angle: 40 * 3.1415926535 / 180,
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 45),

              Container(
                height: 340,
                width: 335,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xFFF6FFFD),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Transaction Summary',
                      style: AppFonts.primaryFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => _buildInfoRow(
                        'Withdrawal Amount',
                        '\$${controller.withdrawalAmount.value.toStringAsFixed(2)}',
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 12),

                    Obx(
                      () => _buildInfoRow(
                        'Processing Fee',
                        '\$${controller.processingFee.value.toStringAsFixed(2)}',
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 12),

                    Obx(
                      () => _buildInfoRow(
                        'Payment Method',
                        controller.paymentMethod.value,
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 12),

                    Obx(
                      () => _buildInfoRow('Account', controller.account.value),
                    ),
                    const SizedBox(height: 32),

                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          Get.to(() => WalletPage());
                        },
                        child: Container(
                          width: 250,
                          height: 40,

                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF206DFF), Color(0xFF319F43)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You Will Receive',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '\$${controller.totalAmount.toStringAsFixed(2)}',
                                style: AppFonts.primaryFont(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.primaryFont(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: AppFonts.primaryFont(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
