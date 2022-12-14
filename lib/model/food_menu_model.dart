import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';

class FoodMenuModel {
  Product data;
  int number;
  int totalAmount;
  int size;

  FoodMenuModel(
      {required this.data, required this.number, required this.totalAmount, required this.size});
}
