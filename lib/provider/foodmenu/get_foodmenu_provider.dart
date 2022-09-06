import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_posttype_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_postype.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:flutter/cupertino.dart';

class GETFoodMenuProvider extends ChangeNotifier {
  List<Product> listProduct = [];
  List<Product> get getlistProduct => listProduct;
  List<FoodMenuModel> _foodMenuModel = [];
  int _totalamount = 0;

  int get totalamont => _totalamount;
  List<FoodMenuModel> get getFoodMenuModel => _foodMenuModel;

  Future<List<Product>?> getProduct() async {
    GetFoodMenuModels? modelsProduct = await getfoodmenu();
    if (modelsProduct != null) {
      listProduct = modelsProduct.product!;
      GetFoodMenuPostTypeModels? models = await getfoodmenutype();
      // if (models != null) {}
      notifyListeners();
    }

    return listProduct;
  }

  // ໃຊ້ຕອນເພີ່ມເມນູ
  void setFoodMenuData(Product data, int number, int totalAmount) {
    List<FoodMenuModel> foodData =
        _foodMenuModel.where((element) => element.data.id == data.id).toList();

    ///  ຖ້າຍັງບໍ່ມີເມນູດັ່ງກ່າວ
    if (foodData.isEmpty) {
      _foodMenuModel.add(
          FoodMenuModel(data: data, number: number, totalAmount: totalAmount));
    } else {
      for (var i in _foodMenuModel) {
        if (i.data.id == data.id) {
          i.data = data;
          i.number = number;
          i.totalAmount = totalAmount;
        }
      }
    }
    notifyListeners();
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////

  /// ຜົນບວກລາຄາທັງໝົດ
  void addTotalAmount(int totalamount) {
    _totalamount += totalamount;

    notifyListeners();
  }
  //ຜົນລົບລາຄາທັງໝົດ
  void deleteTotalAmount(int totalamount){
    _totalamount -= totalamount;
    notifyListeners();
  }
  //ລົບຂໍ້ມູນອອກຈາກ provider
   void deleteData(int index) {
    _foodMenuModel.removeAt(index);
    notifyListeners();
  }
}
