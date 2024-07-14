// import 'dart:ffi';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';

import 'package:tracker/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedcategory = Category.values.last;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month - 1, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text('invalid '),
                content: const Text('please select again'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok'))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('invalid'),
                content: const Text('please look again'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok'))
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();

      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final KeyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, Constraints) {
      final width = Constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, KeyBoardSpace + 10),
            child: Column(
              children: [
                if (width <= 600)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: TextField(
                                // onChanged: _saveTitleInput,

                                controller: _titleController,
                                keyboardType: TextInputType.streetAddress,
                                decoration:
                                    const InputDecoration(label: Text('title')),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 19),
                              child: TextField(
                                // onChanged: _saveTitleInput,
                                controller: _amountController,
                                maxLength: 50,
                                // keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    prefixText: '\$ ', label: Text('Amount')),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DropdownButton(
                              borderRadius: BorderRadius.circular(2),
                              value: _selectedcategory,
                              items: Category.values
                                  .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase())))
                                  .toList(),
                              onChanged: (Value) {
                                if (Value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedcategory = Value;
                                });
                              }),
                          SizedBox(
                            width: 90,
                          ),
                          Text(_selectedDate == null
                              ? 'no date picked'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month))
                        ],
                      )
                    ],
                  )
                else
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: TextField(
                                // onChanged: _saveTitleInput,

                                controller: _titleController,
                                keyboardType: TextInputType.streetAddress,
                                decoration:
                                    const InputDecoration(label: Text('title')),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 19),
                              child: TextField(
                                // onChanged: _saveTitleInput,
                                controller: _amountController,
                                maxLength: 50,
                                // keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    prefixText: '\$ ', label: Text('Amount')),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DropdownButton(
                              borderRadius: BorderRadius.circular(2),
                              value: _selectedcategory,
                              items: Category.values
                                  .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase())))
                                  .toList(),
                              onChanged: (Value) {
                                if (Value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedcategory = Value;
                                });
                              }),
                          SizedBox(
                            width: 125,
                          ),
                          Text(_selectedDate == null
                              ? 'no date picked'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month))
                        ],
                      )
                    ],
                  ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cansel'),
                    ),
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Save Expense"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
