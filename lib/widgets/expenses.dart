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
      context: context,
      builder: (context) => const NewExpense(),
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
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}
