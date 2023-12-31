import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _dateFormatter = DateFormat.yMd();
  final _titleController = TextEditingController();
  final _numberController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.leisure;

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1, DateTime.now().month),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        if (value != null) {
          _selectedDate = value;
        }
      });
    });
  }

  void _submitExpense() {
    var pickedNumber = double.tryParse(_numberController.text);

    if (_titleController.text.trim().isEmpty ||
        pickedNumber == null ||
        pickedNumber <= 0) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Invalid Input"),
              content: const Text("Please make sure the inputs are valid."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("OK"),
                )
              ],
            );
          });
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: pickedNumber,
          dateTime: _selectedDate,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            top: 16, bottom: keyboardSpace + 16, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Category"),
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            } else {
                              return;
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _numberController,
                      decoration: const InputDecoration(
                          label: Text('Amount'), prefixText: '\$'),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 75,
                  ),
                  Row(
                    children: [
                      Text(
                        _selectedDate == null
                            ? "Select Date"
                            : _dateFormatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: () => _pickDate(),
                        icon: const Icon(Icons.date_range),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade200,
                        foregroundColor: Colors.white),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitExpense();
                    },
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
