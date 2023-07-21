import 'package:flutter/material.dart';

import 'models/expense.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('The chart'),
        Text('Expense List..'),
      ],
    );
  }
}
