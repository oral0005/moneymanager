import 'package:flutter/material.dart' hide DateUtils;
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/category_provider.dart';
import '../utils/date_utils.dart';
import '../models/category.dart';
import '../components/tabbar.dart';

class TransactionList extends StatefulWidget {
  final int? accountId;
  final VoidCallback? onBack;

  const TransactionList({super.key, this.accountId, this.onBack});

  @override
  TransactionListState createState() => TransactionListState();
}

class TransactionListState extends State<TransactionList> {
  String _filterType = filterTabs[0]; // 'all'

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    // Filter transactions by accountId if provided
    final filteredTransactions = widget.accountId == null
        ? transactionProvider.transactions
        : transactionProvider.transactions
            .where((t) => t.accountId == widget.accountId)
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            }
          },
        ),
        title: const Text('Транзакции'),
      ),
      body: Column(
        children: [
          // Custom TabBar for filter selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FilterTabBar(
              selected: _filterType,
              onChanged: (value) async {
                setState(() {
                  _filterType = value;
                  transactionProvider.setFilter(value);
                });
                if (value == 'custom') {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    transactionProvider.setFilter('custom', startDate: date, endDate: date);
                  }
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                final category = categoryProvider.categories.firstWhere(
                  (c) => c.id == transaction.categoryId,
                  orElse: () => Category(id: 0, name: 'Unknown'),
                );
                return ListTile(
                  title: Text('${transaction.type.toUpperCase()}: \$${transaction.amount.toStringAsFixed(2)}'),
                  subtitle: Text('${category.name} • ${DateUtils.formatDate(transaction.date)}'),
                  trailing: Icon(
                    transaction.type == 'income' ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(transaction.type.toUpperCase()),
                        content: Text(
                          'Amount: \$${transaction.amount.toStringAsFixed(2)}\n'
                          'Category: ${category.name}\n'
                          'Date: ${DateUtils.formatDate(transaction.date)}\n'
                          'Description: ${transaction.description.isEmpty ? 'None' : transaction.description}',
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}