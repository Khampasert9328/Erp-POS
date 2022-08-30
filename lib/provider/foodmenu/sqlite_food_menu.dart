import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:flutter/foundation.dart';

class FoodSlite extends ChangeNotifier {
  List<Product> listdata = [];
  List<Product> get getlistProduct => listdata;
String? name;
  Future<List<Product>?> getProduct(int index) async {
    GetFoodMenuModels? modelsProduct = await getfoodmenu();
    if (modelsProduct != null) {
      listdata = modelsProduct.product!;
      name = listdata.first.name;
      print("name:$name");
      
      notifyListeners();
    }

    return listdata;
  }
}