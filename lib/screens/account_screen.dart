import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/account.dart';
import 'package:provider/provider.dart';
import '../providers/account_provider.dart';
import '../widgets/transaction_list_account.dart';
import '../widgets/add_account_form.dart'; // Импортируйте ваш новый экран

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int? selectedAccountId;
  bool _deleteMode = false;

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
        title: const Text('Accounts', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF27282D),
        leading: IconButton(
          icon: Icon(
            _deleteMode ? Icons.check : Icons.edit,
            color: Colors.white,
          ),
          tooltip: 'Change',
          onPressed: () {
            setState(() {
              _deleteMode = !_deleteMode;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              // Открываем отдельную страницу для создания аккаунта
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddAccountForm(),
                ),
              );
              // Если аккаунт был добавлен, обновляем список
              if (result == true) {
                Provider.of<AccountProvider>(context, listen: false).fetchAccounts();
              }
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFF27282D),
        child: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
            return Card(
              color: const Color(0xFF212227),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Color.fromARGB(255, 116, 116, 116), width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              child: Row(
                children: [
                  if (_deleteMode)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await Provider.of<AccountProvider>(context, listen: false)
                            .deleteAccount(account.id);
                      },
                    ),
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      dense: true,
                      minVerticalPadding: 0,
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              account.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            '\$${account.balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFFB0B0B0),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      onTap: () {
                        if (!_deleteMode) {
                          setState(() {
                            selectedAccountId = account.id;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}