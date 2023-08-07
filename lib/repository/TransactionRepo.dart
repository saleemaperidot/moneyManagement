import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementclone/Model/transactionModel.dart';
import 'package:moneymanagementclone/servises/transaction_servises.dart';

String transactionDB = "transaction_db";

class TransactionRepo extends transactionServices {
  TransactionRepo._internal();
  static TransactionRepo instance = TransactionRepo._internal();
  factory TransactionRepo() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel transactionModel) async {
    final _transactiondb = await Hive.openBox<TransactionModel>(transactionDB);
    await _transactiondb.put(transactionModel.id, transactionModel);
  }

  @override
  Future<List<TransactionModel>> getTranscation() async {
    final _transactiondb = await Hive.openBox<TransactionModel>(transactionDB);
    return _transactiondb.values.toList();
  }

  ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);
  Future<void> refreshTransactionUI() async {
    final _list = await getTranscation();
    _list.sort(((a, b) => b.date.compareTo(a.date)));
    transactionNotifier.value.clear();
    transactionNotifier.value.addAll(_list);
    transactionNotifier.notifyListeners();
    print("rebuild after delete");
  }

  Future<void> deleteTransaction(String transactionId) async {
    final _transactiondb = await Hive.openBox<TransactionModel>(transactionDB);
    _transactiondb.delete(transactionId);

    print(_transactiondb.values.toString());
    print(transactionId);
    refreshTransactionUI();
  }
}
