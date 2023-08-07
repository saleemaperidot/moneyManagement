import 'package:hive_flutter/hive_flutter.dart';

import 'package:moneymanagementclone/Model/category.dart';
part 'transactionModel.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  CategoryType type;
  @HiveField(4)
  CategoryModel category;
  @HiveField(5)
  String? id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
  @override
  String toString() {
    Map<String, String> a = {'id': '$id!'};
    return a.toString();
  }
}
