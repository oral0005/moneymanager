import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/category_provider.dart';
import '../providers/account_provider.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  AddTransactionFormState createState() => AddTransactionFormState();
}

class AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  double _amount = 0.0;
  String _type = 'expense';
  int _categoryId = 1;
  int _accountId = 1;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter an amount';
                  if (double.tryParse(value) == null || double.parse(value) <= 0) return 'Enter a valid amount';
                  return null;
                },
                onChanged: (value) => _amount = double.tryParse(value) ?? 0.0,
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'income', child: Text('Income')),
                  DropdownMenuItem(value: 'expense', child: Text('Expense')),
                ],
                onChanged: (value) => setState(() => _type = value!),
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black,
                iconEnabledColor: const Color(0xFFFFD700),
              ),
              const SizedBox(height: 16),
              DropdownButton<int>(
                value: _categoryId,
                items: categoryProvider.categories
                    .map((c) => DropdownMenuItem<int>(value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (value) => setState(() => _categoryId = value!),
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black,
                iconEnabledColor: const Color(0xFFFFD700),
              ),
              const SizedBox(height: 16),
              DropdownButton<int>(
                value: _accountId,
                items: accountProvider.accounts
                    .map((a) => DropdownMenuItem<int>(value: a.id, child: Text(a.name)))
                    .toList(),
                onChanged: (value) => setState(() => _accountId = value!),
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black,
                iconEnabledColor: const Color(0xFFFFD700),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final transaction = Transaction(
                        id: DateTime.now().millisecondsSinceEpoch,
                        amount: _amount,
                        type: _type,
                        categoryId: _categoryId,
                        accountId: _accountId,
                        date: DateTime.now(),
                        description: _description,
                      );
                      Provider.of<TransactionProvider>(context, listen: false).addTransaction(transaction);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Transaction'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}