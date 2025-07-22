import 'package:flutter/foundation.dart' hide Category;
import '../models/category.dart';
import '../services/database_helper.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    _categories = await DatabaseHelper.instance.getCategories();
    notifyListeners();
  }
}