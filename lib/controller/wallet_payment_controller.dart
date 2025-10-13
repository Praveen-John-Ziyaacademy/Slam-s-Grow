import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var balance = 5000.00.obs;
  var weeklyIncrease = 250.0.obs;
  var selectedTab = 0.obs;
  var selectedFilter = 'All'.obs;

  var earnings = <Map<String, dynamic>>[
    {'title': 'Tasks', 'amount': 400.0},
    {'title': 'Referrals', 'amount': 150.0},
    {'title': 'Bonuses', 'amount': 50.0},
  ].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  void withdraw() {
    Get.snackbar(
      'Withdrawal',
      'Processing withdrawal request...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}
