import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementclone/Model/category.dart';
import 'package:moneymanagementclone/Model/transactionModel.dart';
import 'package:moneymanagementclone/presentation/category/addCategoryPop.dart';
import 'package:moneymanagementclone/presentation/category/category.dart';
import 'package:moneymanagementclone/presentation/transaction/add_transaction.dart';
import 'package:moneymanagementclone/presentation/transaction/transaction.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ValueNotifier _notifier = ValueNotifier(0);
  final pages = [
    TransactionScreen(),
    CategoryScreen(),
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: _notifier,
              builder: (BuildContext context, value, _) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Moneymanagement clone"),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                      currentIndex: _notifier.value,
                      onTap: (value) {
                        _notifier.value = value;
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'Transaction'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.category), label: 'category')
                      ]),
                  body: pages[_notifier.value],
                  floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        if (_notifier.value == 0) {
//show screen to add transaction
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddTransactionScreen(),
                          ));
                        } else {
                          AddCategoryShowPopup(context);
                          //add pop up to add category
                        }
                      }),
                );
              })),
    );
  }
}
