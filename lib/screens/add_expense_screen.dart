import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleCtrl.text;
    final enteredAmount = double.tryParse(_amountCtrl.text) ?? 0;
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    Provider.of<ExpenseProvider>(context, listen: false)
        .addExpense(enteredTitle, enteredAmount, DateTime.now());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: cs.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),

        Text(
          'Add New Expense',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        SizedBox(height: 12),

        TextField(
          decoration: InputDecoration(labelText: 'Title'),
          controller: _titleCtrl,
        ),
        SizedBox(height: 12),

        TextField(
          decoration: InputDecoration(labelText: 'Amount'),
          controller: _amountCtrl,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(height: 16),

        ElevatedButton.icon(
          icon: Icon(Icons.check),
          label: Text('Add Expense'),
          style: ElevatedButton.styleFrom(
            backgroundColor: cs.primary,
            foregroundColor: cs.onPrimary,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _submitData,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
