import 'package:expense_tracker/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            // margin: EdgeInsets.symmetric(
            //   horizontal: Theme.of(context).cardTheme.margin?.horizontal ?? 0,
            //   //vertical: Theme.of(context).cardTheme.margin?.vertical ?? 0,
            // ),
            color: Theme.of(context).colorScheme.error,
          ),
          child: ExpenseItem(expense: expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
      ),
    );
  }
}