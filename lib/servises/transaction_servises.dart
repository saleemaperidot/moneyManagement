import 'package:moneymanagementclone/Model/transactionModel.dart';

abstract class transactionServices {
  Future<void> addTransaction(TransactionModel transactionModel);
  Future<List<TransactionModel>> getTranscation();
}
