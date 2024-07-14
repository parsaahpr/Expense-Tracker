// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tracker/expense.dart';
import 'package:tracker/expense_item.dart';

// import 'package:tracker/expenses.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemovedExpense});
  final List<Expense> expenses;
  final void Function(Expense) onRemovedExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.2),
              margin: Theme.of(context).cardTheme.margin!,
            ),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemovedExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index])));
  }
}
