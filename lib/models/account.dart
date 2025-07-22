class Account {
  final int id;
  final String name;
  final double balance;

  Account({required this.id, required this.name, required this.balance});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }
}