import 'package:flutter/foundation.dart';
import '../models/account.dart';
import '../services/database_helper.dart';

class AccountProvider with ChangeNotifier {
  List<Account> _accounts = [];

  List<Account> get accounts => _accounts;

  Future<void> fetchAccounts() async {
    _accounts = await DatabaseHelper.instance.getAccounts();
    notifyListeners();
  }

  Future<void> addAccount(Account account) async {
    await DatabaseHelper.instance.insertAccount(account);
    await fetchAccounts();
  }

  Future<void> deleteAccount(int id) async {
    await DatabaseHelper.instance.deleteAccount(id);
    await fetchAccounts();
  }
}