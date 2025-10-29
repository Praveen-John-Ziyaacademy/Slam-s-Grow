import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_media/colors/fonts.dart';
import 'package:social_media/controller/wallet/wallet_screen_controller.dart';
import 'package:social_media/models/wallet_models.dart';
import 'package:social_media/screens/wallet_payment_screen.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Wallet & Payments',
          style: AppFonts.primaryFont(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Color(0xFF4CAF50),
        onRefresh: () => controller.refreshActivityData(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  height: 218,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF2196F3)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.25),
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Balance',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(
                                    () => Text(
                                      '\$${controller.balance.value.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 35),
                              child: SvgPicture.asset(
                                'assets/graph 1.svg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => WalletPaymentsScreen());
                              },
                              child: Container(
                                width: 140,
                                height: 39,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF319F43),
                                      Color(0xFF2070FF),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.25),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.download,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Withdraw Funds',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // History Button
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 140,
                                height: 39,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.30),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.25),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.history,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'History',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF2196F3).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: Color(0xFF2196F3),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'App Activity',
                                style: AppFonts.primaryFont(
                                  color: const Color(0xFF2070FF),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'This Week',
                                style: AppFonts.primaryFont(
                                  fontSize: 10,
                                  color: const Color(0xFF00BD4A),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                '5/7',
                                style: AppFonts.primaryFont(
                                  fontSize: 16,
                                  color: const Color(0xFF00BD4A),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Days Active',
                                style: AppFonts.primaryFont(fontSize: 8),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildHeatmapChart(),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem(Color(0xFF4CAF50), 'Active Day'),
                          SizedBox(width: 16),
                          _buildLegendItem(Colors.grey[500]!, 'Inactive Day'),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    Obx(
                      () => Row(
                        children: [
                          _buildFilterChip('All'),
                          SizedBox(width: 8),
                          _buildFilterChip('Credit'),
                          SizedBox(width: 8),
                          _buildFilterChip('Debit'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction =
                              controller.filteredTransactions[index];
                          return _buildTransactionItem(transaction);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeatmapChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final activityData = [
      [6, 6, 6, 6, 6, 6, 6, 9, 9, 9, 9, 9, 9],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [6, 6, 6, 6, 6, 6, 6, 9, 9, 9, 9, 9, 9],
      [6, 6, 6, 6, 6, 6, 6, 9, 9, 9, 9, 9, 9],
      [6, 6, 6, 6, 6, 6, 6, 9, 9, 9, 9, 9, 9],
      [6, 6, 6, 6, 6, 6, 6, 9, 9, 9, 9, 9, 9],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ];

    Color getStartColor(int value) {
      if (value == 0) return Colors.grey[300]!;
      return const Color(0xFF2070FF);
    }

    Color getEndColor(int value) {
      if (value == 0) return Colors.grey[300]!;
      return const Color(0xFF00BD4A);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          List.generate(days.length, (dayIndex) {
                final columnData = activityData[dayIndex];
                final isInactive = columnData.every((v) => v == 0);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...List.generate(columnData.length, (index) {
                      double t = index / (columnData.length - 1);
                      Color color = isInactive
                          ? Colors.grey[300]!
                          : Color.lerp(
                              getStartColor(columnData[index]),
                              getEndColor(columnData[index]),
                              t,
                            )!;
                      return Container(
                        width: 18,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: color,
                        ),
                      );
                    }).reversed,
                    const SizedBox(height: 12),
                    Text(
                      days[dayIndex],
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              })
              .map(
                (widget) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget,
                ),
              )
              .toList(),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 8, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = controller.selectedFilter.value == label;
    return GestureDetector(
      onTap: () => controller.setFilter(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF2196F3)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final isCredit = transaction.amount > 0;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCredit
                  ? Color(0xFF4CAF50).withOpacity(0.1)
                  : Color(0xFFFF5252).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isCredit ? Icons.south_east : Icons.north_west,
              color: isCredit ? Color(0xFF4CAF50) : Color(0xFFFF5252),
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  '${transaction.date.month.toString().padLeft(2, '0')} ${transaction.date.day.toString().padLeft(2, '0')},${transaction.date.year}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isCredit ? Color(0xFF4CAF50) : Color(0xFFFF5252),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
