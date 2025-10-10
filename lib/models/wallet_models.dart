class Transaction {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });
}

enum TransactionType { credit, debit }
