import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../services/database_helper.dart';
import '../utils/date_utils.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  String _filterType = 'all'; // 'day', 'month', 'custom'
  DateTime? _startDate;
  DateTime? _endDate;
  int? _accountId;

  List<Transaction> get transactions => _transactions;
  String get filterType => _filterType;

  Future<void> fetchTransactions({int? accountId}) async {
    _accountId = accountId;
    DateTime? startDate;
    DateTime? endDate;

    if (_filterType == 'day') {
      startDate = DateUtils.startOfDay(DateTime.now());
      endDate = DateUtils.endOfDay(DateTime.now());
    } else if (_filterType == 'month') {
      startDate = DateUtils.startOfMonth(DateTime.now());
      endDate = DateUtils.endOfMonth(DateTime.now());
    } else if (_filterType == 'custom' && _startDate != null && _endDate != null) {
      startDate = _startDate;
      endDate = _endDate;
    }

    _transactions = await DatabaseHelper.instance.getTransactions(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
    );
    notifyListeners();
  }

  void setFilter(String filterType, {DateTime? startDate, DateTime? endDate}) {
    _filterType = filterType;
    _startDate = startDate;
    _endDate = endDate;
    fetchTransactions(accountId: _accountId);
  }

  Future<void> addTransaction(Transaction transaction) async {
    await DatabaseHelper.instance.addTransaction(transaction);
    await fetchTransactions(accountId: _accountId);
  }

  double getTotalIncome() {
    return _transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double getTotalExpense() {
    return _transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}