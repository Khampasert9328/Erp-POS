import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';

class FoodMenuModel {
  Product data;
  int totalAmount;
  int size;
  int amount;
  int specialprice;
  String categoryname;
  FoodMenuModel({
    required this.data,
    required this.totalAmount,
    required this.size,
    required this.amount,
    required this.specialprice,
    required this.categoryname,
  });
}
