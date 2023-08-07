import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanagementclone/Model/category.dart';
import 'package:moneymanagementclone/repository/CategoryRepo.dart';

class IncomeTabView extends StatelessWidget {
  const IncomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryRepo().incomeCategoryListner,
      builder: (context, value, child) {
        return ListView.separated(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final category = value[index];
            print("@@@@@@@@@$category");
            return Card(
              child: ListTile(
                  leading: Text(category.name),
                  trailing: IconButton(
                      onPressed: () {
                        CategoryRepo.instance.delete(category.id);
                      },
                      icon: Icon(Icons.delete))),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }
}
