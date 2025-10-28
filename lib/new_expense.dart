import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showErrorDialogue(String message) {
    showDialog(context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Invalid Input"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _submitExpenseData() {
    if (_titleController.text.trim().isEmpty) {
      _showErrorDialogue("Please enter a valid title.");
      return;
    }
    final enteredAmnt = double.tryParse(_amountController.text);
    if (enteredAmnt == null || enteredAmnt <= 0) {
      _showErrorDialogue("Please enter a valid amount.");
      return;
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final chosenDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = chosenDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(label: Text("Title")),
            controller: _titleController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                  controller: _amountController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                  crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Chosen"
                        : formatter.format(_selectedDate!)), // note to self: ! means "this nullable variable isnt null, trust me", so dart wont throw potential null exceptions/errors
                    IconButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  ),
                ).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
