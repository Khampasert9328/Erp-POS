import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_posttype_models.dart';
import 'package:erp_pos/pages/food_menu/models/food_menu_data_model.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_postype.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:flutter/cupertino.dart';

class GetFoodMenuProvider extends ChangeNotifier {
  List<FoodMenuDataModel> listProduct = [];
  List<FoodMenuDataModel> get getlistProduct => listProduct;
  List<FoodMenuModel> foodMenuModel = [];
  int _totalamount = 0;
  GetFoodMenuModels? modelsProduct;
  GetFoodMenuModels? get getModelsProduct => modelsProduct;
  int get totalamont => _totalamount;
  List<FoodMenuModel> get getFoodMenuModel => foodMenuModel;

  /// ດຶງລາຍການສິນຄ້າໃນເມນູອາຫານ
  Future<void> getProduct(bool forceReload) async {
    if (forceReload) {
      modelsProduct = null;
    }
    if (modelsProduct == null) {
      modelsProduct = await getfoodmenu();
      if (modelsProduct != null) {
        listProduct.clear();
        for (Product i in modelsProduct!.product!) {
          listProduct.add(FoodMenuDataModel(data: i, size: 0));
        }
      }
    }
    notifyListeners();
  }

  // ໃຊ້ຕອນເພີ່ມເມນູ
  void setFoodMenuData(Product data, int number, int totalAmount) {
    List<FoodMenuModel> foodData =
        foodMenuModel.where((element) => element.data.id == data.id).toList();

    ///  ຖ້າຍັງບໍ່ມີເມນູດັ່ງກ່າວ
    if (foodData.isEmpty) {
      foodMenuModel.add(
          FoodMenuModel(data: data, number: number, totalAmount: totalAmount));
    } else {
      for (var i in foodMenuModel) {
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
  void deleteTotalAmount(int totalamount) {
    _totalamount -= totalamount;
    notifyListeners();
  }

  //ລົບຂໍ້ມູນອອກຈາກ provider
  void deleteData(int? index, int amount) {
    foodMenuModel.removeAt(index!);
    _totalamount -= amount;
    notifyListeners();
  }

  void clearKitchenData() {
    _totalamount = 0;
    foodMenuModel = [];
    notifyListeners();
  }
}
