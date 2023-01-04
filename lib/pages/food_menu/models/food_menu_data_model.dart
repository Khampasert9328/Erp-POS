import 'package:erp_pos/model/foodmenu/food_menu_models.dart';

class FoodMenuDataModel{
  Product data;
  int size;
  bool isaddtochart;
  int count;
  FoodMenuDataModel({required this.data, required this.size, required this.isaddtochart, required this.count});
}