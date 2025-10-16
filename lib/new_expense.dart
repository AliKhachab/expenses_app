import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
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
                    Text("Selected Date"),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel Expense"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Save Expense")),
            ],
          ),
        ],
      ),
    );
  }
}
