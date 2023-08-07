import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementclone/Model/category.dart';
import 'package:moneymanagementclone/servises/catogory_servises.dart';

const String DBNAME = 'category_db';

class CategoryRepo implements CategoryServises {
  CategoryRepo._internal();
  static CategoryRepo instance = CategoryRepo._internal();
  factory CategoryRepo() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListner = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListner = ValueNotifier([]);

  @override
  Future<void> insert(CategoryModel categoryModelobj) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(DBNAME);
    _categoryDb.put(categoryModelobj.id, categoryModelobj);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categorydb = await Hive.openBox<CategoryModel>(DBNAME);
    return _categorydb.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryListner.value.clear();
    expenseCategoryListner.value.clear();
    Future.forEach(allCategories, (CategoryModel value) {
      if (value.type == CategoryType.income) {
        incomeCategoryListner.value.add(value);
        incomeCategoryListner.notifyListeners();
      } else {
        expenseCategoryListner.value.add(value);
        expenseCategoryListner.notifyListeners();
      }
    });
  }

  @override
  Future<void> delete(String id) async {
    final _categorydb = await Hive.openBox<CategoryModel>(DBNAME);
    _categorydb.delete(id);
    refreshUI();
  }
}
