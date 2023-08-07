import 'package:moneymanagementclone/Model/category.dart';

abstract class CategoryServises {
  Future<void> insert(CategoryModel categoryModel);
  Future<List<CategoryModel>> getCategories();
  Future<void> delete(String id);
}
