import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagementclone/Model/category.dart';
import 'package:moneymanagementclone/repository/CategoryRepo.dart';

ValueNotifier _notifier = new ValueNotifier(CategoryType.income);

Future<void> AddCategoryShowPopup(BuildContext context) async {
  CategoryType type;
  TextEditingController _textEditingontrolller = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: Text("Add Category"),
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "category"),
            controller: _textEditingontrolller,
          ),
          ValueListenableBuilder(
              valueListenable: _notifier,
              builder: (BuildContext newcontext, newvalue, _) {
                return Container(
                  // width: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: RadioListTile(
                          value: CategoryType.income,
                          groupValue: newvalue,
                          onChanged: (value) {
                            _notifier.value = value;
                            _notifier.notifyListeners();
                          },
                          title: Text("income"),
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: CategoryType.expense,
                          groupValue: newvalue,
                          onChanged: (value) {
                            _notifier.value = value;
                            _notifier.notifyListeners();
                          },
                          title: Text("expense"),
                        ),
                      )
                    ],
                  ),
                );
              }),
          ElevatedButton(
              onPressed: () {
                final _name = _textEditingontrolller.text;
                final _category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _notifier.value);
                CategoryRepo().insert(_category);
                Navigator.pop(context);
                print("inserted");
              },
              child: Text("Add category"))
        ],
      );
    },
  );
}
