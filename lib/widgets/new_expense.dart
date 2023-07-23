import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _numberController = TextEditingController();
  final _dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                  label: Text('Amount'), prefixText: '\$'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
            ),
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                label: Text("Date"),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                _DateInputFormatter(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
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
                    print(" ${_titleController.text}"
                        " ${_numberController.text}");
                  },
                  child: const Text('Save Expense'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;

    String formatted = '';
    int selectionIndex = newValue.selection.baseOffset;
    int day = 0;
    int month = 0;
    int year = 0;

    if (newValue.text.isNotEmpty) {
      final parts = newValue.text.split('/');
      if (parts.isNotEmpty) day = int.tryParse(parts[0]) ?? 0;
      if (parts.length > 1) month = int.tryParse(parts[1]) ?? 0;
      if (parts.length > 2) year = int.tryParse(parts[2]) ?? 0;
    }

    formatted += day > 31 ? '31/' : '${day.toString().padLeft(2, '0')}/';
    formatted += month > 12 ? '12/' : '${month.toString().padLeft(2, '0')}/';
    formatted += year.toString().padLeft(4, '0');

    selectionIndex = newValue.selection.baseOffset;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
