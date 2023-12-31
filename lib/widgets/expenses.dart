import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'expenses_list/expenses_list.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "flutter course",
        amount: 5.2,
        dateTime: DateTime.now(),
        category: Category.work),
    Expense(
        title: "cinema",
        amount: 2.2,
        dateTime: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "eat ",
        amount: 2.2,
        dateTime: DateTime.now(),
        category: Category.food),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("You have removed the expense"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        leadingWidth: 8,
        title: const Text("Expense Tracker App"),
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: (_registeredExpenses.isEmpty)
                ? const Center(child: Text("No expense found."))
                : ExpensesList(
                    expenses: _registeredExpenses,
                    removeExpense: _removeExpense,
                  ),
          )
        ],
      ),
    );
  }
}
