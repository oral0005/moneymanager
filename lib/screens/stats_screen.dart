import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Income: \$${provider.getTotalIncome().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total Expenses: \$${provider.getTotalExpense().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Spending Breakdown',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          // Placeholder for chart (to be implemented)
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDAA520)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Chart Placeholder (e.g., Pie Chart)',
                style: TextStyle(color: Color(0xFFB0B0B0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}