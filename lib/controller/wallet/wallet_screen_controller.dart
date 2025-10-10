import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:social_media/models/wallet_models.dart';

class WalletController extends GetxController {
  var balance = 2650.0.obs;
  var selectedFilter = 'All'.obs;
  var transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
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
