// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import 'add_expense_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expProv = Provider.of<ExpenseProvider>(context);
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: cs.secondary,
        actions: [
          if (expProv.selectedIds.isNotEmpty) ...[
            IconButton(
              icon: Icon(Icons.calculate),
              tooltip: 'Sum Selected',
              onPressed: () {
                final total = expProv.selectedTotal;
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Total of Selected'),
                    content:
                    Text('\$${total.toStringAsFixed(2)}'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      )
                    ],
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_sweep),
              tooltip: 'Delete Selected',
              onPressed: () => expProv.deleteSelected(),
            ),
          ]
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: expProv.items.isEmpty
              ? Center(
            child: Text(
              'No expenses yet.',
              style: TextStyle(
                fontSize: 18,
                color:
                cs.onBackground.withOpacity(0.6),
              ),
            ),
          )
              : ListView.builder(
            itemCount: expProv.items.length,
            itemBuilder: (ctx, i) {
              final e = expProv.items[i];
              final isSelected =
              expProv.selectedIds.contains(e.id);
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                    vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isSelected,
                        activeColor: cs.primary,
                        onChanged: (_) =>
                            expProv.toggleSelect(e.id),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w600,
                                color: cs.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              DateFormat.yMMMd()
                                  .format(e.date),
                              style: TextStyle(
                                color: cs.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${e.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
                              color: cs.primary,
                            ),
                          ),
                          SizedBox(height: 4),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color:
                                Colors.redAccent),
                            onPressed: () =>
                                expProv.removeExpense(
                                    e.id),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 28),
        backgroundColor: cs.primary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) => DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (ctx, scrollCtl) => Padding(
                padding:
                EdgeInsets.only(bottom: bottomInset),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius:
                    BorderRadius.vertical(
                        top: Radius.circular(16)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollCtl,
                    child: AddExpenseScreen(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endFloat,
    );
  }
}
