import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_posttype_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_postype.dart';


import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:flutter/cupertino.dart';

class FoodMenuProvider extends ChangeNotifier {
  List<Product> listProduct = [];
  List<Product> get getlistProduct => listProduct;

  Future<List<Product>?> getProduct() async {
    GetFoodMenuModels? modelsProduct = await getfoodmenu();
    if (modelsProduct != null) {
      listProduct = modelsProduct.product!;
      GetFoodMenuPostTypeModels? models= await getfoodmenutype();
      if (models !=null) {
      }
      notifyListeners();
    }

    return listProduct;
  }
}
