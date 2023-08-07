import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneymanagementclone/repository/CategoryRepo.dart';
import 'package:moneymanagementclone/repository/TransactionRepo.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionRepo.instance.refreshTransactionUI();
    CategoryRepo.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionRepo.instance.transactionNotifier,
        builder: (context, value, child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final _value = value[index];
                print(value);
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (ctx) {
                          TransactionRepo.instance
                              .deleteTransaction(_value.id!);
                        },
                        icon: Icons.delete,
                        label: 'delete',
                      )
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.red),
                      title: Text("Category name"),
                      subtitle: Text("Sub title"),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: value.length);
        });
  }
}
