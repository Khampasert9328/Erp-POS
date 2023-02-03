import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/services/getcategory/get_category.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  GetCategoryModels? _category;
  GetCategoryModels? get category => _category;
  bool _isloading = false;
  bool get isloading => _isloading;
  Future<void> getCategoryProvider() async {
    try {
      _isloading = true;
      _category = await getCategory();
    } catch (e) {
      rethrow;
    }
    _isloading = false;
    notifyListeners();
  }
}
