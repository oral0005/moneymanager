import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/account_provider.dart';
import '../widgets/transaction_list_account.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int? selectedAccountId;

  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<AccountProvider>(context).accounts;

    if (selectedAccountId != null) {
      return TransactionList(
        accountId: selectedAccountId!,
        onBack: () {
          setState(() {
            selectedAccountId = null;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts',
        style: TextStyle(
          color: Colors.white, // Ensure the title is visible against the background
        )),
        centerTitle: true, // Optional: center the title
        backgroundColor: const Color(0xFF27282D), // Optional
      ),
      body: Container(
        color: const Color(0xFF27282D), // Match the app's background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(account.name),
                  subtitle: Text(
                    'Balance: \$${account.balance.toStringAsFixed(2)}',
                    style: const TextStyle(color: Color(0xFFB0B0B0)),
                  ),
                  onTap: () {
                    setState(() {
                      selectedAccountId = account.id;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}