import 'package:flutter/foundation.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _items = [];
  final Set<String> _selectedIds = {};


  List<Expense> get items => List.unmodifiable(_items);
  Set<String> get selectedIds => _selectedIds;

  double get selectedTotal => _items
      .where((e) => _selectedIds.contains(e.id))
      .fold(0.0, (sum, e) => sum + e.amount);

  void addExpense(String title, double amount, DateTime date) {
    final newExp = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    _items.insert(0, newExp);
    notifyListeners();
  }

  void toggleSelect(String id) {
    if (_selectedIds.contains(id)) _selectedIds.remove(id);
    else _selectedIds.add(id);
    notifyListeners();
  }

  void clearSelection() {
    _selectedIds.clear();
    notifyListeners();
  }

  void deleteSelected() {
    _items.removeWhere((e) => _selectedIds.contains(e.id));
    clearSelection();
    notifyListeners();
  }

  void removeExpense(String id) {
    _items.removeWhere((exp) => exp.id == id);
    notifyListeners();
  }
}
