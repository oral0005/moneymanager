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
}