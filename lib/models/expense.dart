import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_file.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();
enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.travel: Icons.airplanemode_active_outlined,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final String title;
  final double amount;
  final String id;
  final DateTime dateTime;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.dateTime,
      required this.category})
      : id = uuid.v4();

  String get formattedDate {
    return formatter.format(dateTime);
  }
}
