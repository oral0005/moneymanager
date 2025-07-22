class Transaction {
  final int id;
  final double amount;
  final String type; // 'income' or 'expense'
  final int categoryId;
  final int accountId;
  final DateTime date;
  final String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.accountId,
    required this.date,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'categoryId': categoryId,
      'accountId': accountId,
      'date': date.toIso8601String(),
      'description': description,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      amount: map['amount'],
      type: map['type'],
      categoryId: map['categoryId'],
      accountId: map['accountId'],
      date: DateTime.parse(map['date']),
      description: map['description'],
    );
  }
}