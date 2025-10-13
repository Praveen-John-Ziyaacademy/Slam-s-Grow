// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:social_media/models/wallet_models.dart';

// class WalletController extends GetxController {
//   var balance = 2650.0.obs;
//   var selectedFilter = 'All'.obs;
//   var transactions = <Transaction>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadTransactions();
//   }

//   void loadTransactions() {
//     transactions.value = [
//       Transaction(
//         title: 'Task Completion Reward',
//         amount: 150.00,
//         date: DateTime(2025, 10, 8),
//         type: TransactionType.credit,
//       ),
//       Transaction(
//         title: 'Daily Survey Bonus',
//         amount: 50.00,
//         date: DateTime(2025, 10, 7),
//         type: TransactionType.credit,
//       ),
//       Transaction(
//         title: 'Withdrawal to Bank',
//         amount: -500.00,
//         date: DateTime(2025, 10, 5),
//         type: TransactionType.debit,
//       ),
//       Transaction(
//         title: 'Referral Bonus',
//         amount: 200.00,
//         date: DateTime(2025, 10, 5),
//         type: TransactionType.credit,
//       ),
//       Transaction(
//         title: 'Weekly Challenge Wins',
//         amount: 300.00,
//         date: DateTime(2025, 10, 4),
//         type: TransactionType.credit,
//       ),
//       Transaction(
//         title: 'Withdrawal to UPI',
//         amount: -200.00,
//         date: DateTime(2025, 10, 3),
//         type: TransactionType.debit,
//       ),
//       Transaction(
//         title: 'Task Completion Reward',
//         amount: 100.00,
//         date: DateTime(2025, 10, 1),
//         type: TransactionType.credit,
//       ),
//       Transaction(
//         title: 'Shop Purchase',
//         amount: -75.00,
//         date: DateTime(2025, 10, 3),
//         type: TransactionType.debit,
//       ),
//     ];
//   }

//   void setFilter(String filter) {
//     selectedFilter.value = filter;
//   }

//   List<Transaction> get filteredTransactions {
//     if (selectedFilter.value == 'All') {
//       return transactions;
//     } else if (selectedFilter.value == 'Credit') {
//       return transactions
//           .where((t) => t.type == TransactionType.credit)
//           .toList();
//     } else {
//       return transactions
//           .where((t) => t.type == TransactionType.debit)
//           .toList();
//     }
//   }
// }

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/models/wallet_models.dart';

class WalletController extends GetxController {
  var balance = 2650.0.obs;
  var selectedFilter = 'All'.obs;
  var transactions = <Transaction>[].obs;

  // Weekly activity data
  var weeklyActivity = <DailyActivity>[].obs;
  var isLoadingActivity = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    loadWeeklyActivity();
  }

  void loadTransactions() {
    transactions.value = [
      Transaction(
        title: 'Task Completion Reward',
        amount: 150.00,
        date: DateTime(2025, 10, 8),
        type: TransactionType.credit,
      ),
      Transaction(
        title: 'Daily Survey Bonus',
        amount: 50.00,
        date: DateTime(2025, 10, 7),
        type: TransactionType.credit,
      ),
      Transaction(
        title: 'Withdrawal to Bank',
        amount: -500.00,
        date: DateTime(2025, 10, 5),
        type: TransactionType.debit,
      ),
      Transaction(
        title: 'Referral Bonus',
        amount: 200.00,
        date: DateTime(2025, 10, 5),
        type: TransactionType.credit,
      ),
      Transaction(
        title: 'Weekly Challenge Wins',
        amount: 300.00,
        date: DateTime(2025, 10, 4),
        type: TransactionType.credit,
      ),
      Transaction(
        title: 'Withdrawal to UPI',
        amount: -200.00,
        date: DateTime(2025, 10, 3),
        type: TransactionType.debit,
      ),
      Transaction(
        title: 'Task Completion Reward',
        amount: 100.00,
        date: DateTime(2025, 10, 1),
        type: TransactionType.credit,
      ),
      Transaction(
        title: 'Shop Purchase',
        amount: -75.00,
        date: DateTime(2025, 10, 3),
        type: TransactionType.debit,
      ),
    ];
  }

  Future<void> loadWeeklyActivity() async {
    try {
      isLoadingActivity.value = true;

      await Future.delayed(Duration(seconds: 1));

      weeklyActivity.value = _generateDummyWeeklyData();

      isLoadingActivity.value = false;
    } catch (e) {
      print('Error loading weekly activity: $e');
      isLoadingActivity.value = false;

      Get.snackbar('Error', 'Failed to load activity data');
    }
  }

  List<DailyActivity> _generateDummyWeeklyData() {
    final now = DateTime.now();
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return List.generate(7, (index) {
      final isActive = index != 1 && index != 5 && index != 6;
      final earnings = isActive ? (50.0 + (index * 20.0)) : 0.0;

      return DailyActivity(
        date: now.subtract(Duration(days: 6 - index)),
        dayName: weekDays[index],
        wasActive: isActive,
        earnings: earnings,
        activityMinutes: isActive ? (30 + (index * 10)) : 0,
      );
    });
  }

  Future<void> refreshActivityData() async {
    await loadWeeklyActivity();
  }

  int get activeDaysCount {
    return weeklyActivity.where((day) => day.wasActive).length;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  List<Transaction> get filteredTransactions {
    if (selectedFilter.value == 'All') {
      return transactions;
    } else if (selectedFilter.value == 'Credit') {
      return transactions
          .where((t) => t.type == TransactionType.credit)
          .toList();
    } else {
      return transactions
          .where((t) => t.type == TransactionType.debit)
          .toList();
    }
  }
}

class DailyActivity {
  final DateTime date;
  final String dayName;
  final bool wasActive;
  final double earnings;
  final int activityMinutes;

  DailyActivity({
    required this.date,
    required this.dayName,
    required this.wasActive,
    required this.earnings,
    required this.activityMinutes,
  });

  factory DailyActivity.fromJson(Map<String, dynamic> json) {
    return DailyActivity(
      date: DateTime.parse(json['date']),
      dayName: json['day_name'] ?? '',
      wasActive: json['was_active'] ?? false,
      earnings: (json['earnings'] ?? 0.0).toDouble(),
      activityMinutes: json['activity_minutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'day_name': dayName,
      'was_active': wasActive,
      'earnings': earnings,
      'activity_minutes': activityMinutes,
    };
  }
}

class WalletApiService {
  static const String baseUrl = 'https://your-api.com/api';

  static Future<List<DailyActivity>> getWeeklyActivity() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallet/weekly-activity'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _getAuthToken()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<DailyActivity> activities = [];

        for (var item in data['activities']) {
          activities.add(DailyActivity.fromJson(item));
        }

        return activities;
      } else {
        throw Exception('Failed to load weekly activity');
      }
    } catch (e) {
      print('Error fetching weekly activity: $e');
      rethrow;
    }
  }

  static Future<double> getUserBalance() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wallet/balance'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _getAuthToken()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['balance'] ?? 0.0).toDouble();
      } else {
        throw Exception('Failed to load balance');
      }
    } catch (e) {
      print('Error fetching balance: $e');
      rethrow;
    }
  }

  static Future<String> _getAuthToken() async {
    return 'your_auth_token_here';
  }
}
