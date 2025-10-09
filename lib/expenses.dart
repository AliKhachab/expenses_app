import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registeredExpenses = [
    Expense(title: "Cheeseburger", amount: 12.45, date: DateTime.now(), category: Category.food),
    Expense(title: "Spider-Man Movie", amount: 15.00, date: DateTime.now(), category: Category.leisure),
    Expense(title: "Office Supplies", amount: 75.23, date: DateTime.now(), category: Category.work),
    Expense(title: "Flight to London", amount: 250.36, date: DateTime.now(), category: Category.travel),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [
        Text("Chart"),
        Text("Expense List")
      ]),
    );
  }
}