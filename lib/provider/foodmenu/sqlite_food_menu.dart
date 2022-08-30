import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:flutter/foundation.dart';

class FoodSlite extends ChangeNotifier {
  int count = 0;
  void addcount(){
    count ++;
    notifyListeners();
  }
}