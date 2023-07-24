import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});




  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          expenses[index],
        ),
        onDismissed: (direction) => removeExpense(
          expenses[index],
        ),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal
          ),
        ),
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
