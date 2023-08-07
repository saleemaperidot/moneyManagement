import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moneymanagementclone/Model/category.dart';
import 'package:moneymanagementclone/Model/transactionModel.dart';
import 'package:moneymanagementclone/repository/CategoryRepo.dart';
import 'package:moneymanagementclone/repository/TransactionRepo.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController _amountcontroller = TextEditingController();
  TextEditingController _purposecontroller = TextEditingController();
  ValueNotifier _notifier = ValueNotifier(CategoryType.income);
  CategoryModel? _selectCategoryModel;
  DateTime? _selectdate;

  String selectesItemCategory = "selected item";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: _purposecontroller,
                decoration: InputDecoration(
                    hintText: "Purpose",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.pink))),
              ),

              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountcontroller,
                decoration: InputDecoration(
                    hintText: "Amount",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.pink))),
              ),
              ValueListenableBuilder(
                valueListenable: _notifier,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Flexible(
                        child: RadioListTile(
                            title: Text("Income"),
                            value: CategoryType.income,
                            groupValue: value,
                            onChanged: (value) {
                              _notifier.value = CategoryType.income;
                              _notifier.notifyListeners();
                            }),
                      ),
                      Flexible(
                        child: RadioListTile(
                            title: Text("expense"),
                            value: CategoryType.expense,
                            groupValue: value,
                            onChanged: (value) {
                              _notifier.value = CategoryType.expense;
                              _notifier.notifyListeners();
                            }),
                      ),
                    ],
                  );
                },
              ),

              //select date
              TextButton.icon(
                  onPressed: () async {
                    final _selectdatetemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 50)),
                        lastDate: DateTime.now());

                    setState(() {
                      _selectdate = _selectdatetemp;
                    });
                  },
                  icon: Icon(Icons.calendar_month),
                  label: Text(_selectdate == null
                      ? "select date"
                      : _selectdate.toString())),

              //category dropdown
              DropdownButton(
                hint: Text(selectesItemCategory),
                items: (_notifier == CategoryType.income
                        ? CategoryRepo().incomeCategoryListner.value
                        : CategoryRepo().expenseCategoryListner.value)
                    .map((e) => DropdownMenuItem(
                        value: e.name,
                        onTap: () {
                          _selectCategoryModel = e;
                        },
                        child: Text(e.name)))
                    .toList(),
                onChanged: (value) {
                  selectesItemCategory = value!;
                },
              ),

              //elevated button
              ElevatedButton(
                onPressed: () {
                  addTransaction(context);
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction(BuildContext context) async {
    final _transaction = TransactionModel(
      purpose: _purposecontroller.text,
      amount: double.parse(_amountcontroller.text),
      date: _selectdate!,
      type: _notifier.value,
      category: _selectCategoryModel!,
    );
    await TransactionRepo.instance.addTransaction(_transaction);
    print(_transaction);
    Navigator.of(context).pop();
    TransactionRepo.instance.refreshTransactionUI();
  }
}
