import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/account_provider.dart';
import '../screens/transaction_screen.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key}); // Use super-initializer for key

  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<AccountProvider>(context).accounts;
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        return ListTile(
          title: Text(account.name),
          subtitle: Text('Balance: ${account.balance}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TransactionList(accountId: account.id),
              ),
            );
          },
        );
      },
    );
  }
}