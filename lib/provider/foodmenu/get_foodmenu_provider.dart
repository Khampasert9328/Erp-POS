import 'dart:math';

import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_posttype_models.dart';
import 'package:erp_pos/pages/food_menu/models/food_menu_data_model.dart';
import 'package:erp_pos/services/getcategory/get_category.dart';
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
  bool isload = false;
  bool get isloading => isload;
  GetCategoryModels? _category;
  GetCategoryModels? get category => _category;

  /// ດຶງລາຍການສິນຄ້າໃນເມນູອາຫານ
  Future<void> getProduct(bool forceReload) async {
    isload = true;
    if (forceReload) {
      modelsProduct = null;
    }
    if (modelsProduct == null) {
      modelsProduct = await getfoodmenu();
      if (modelsProduct != null) {
        _category = await getCategory();
        listProduct.clear();
        for (Product i in modelsProduct!.product!) {
          listProduct.add(FoodMenuDataModel(
              data: i, size: 0, isaddtochart: false, count: 0));
        }
      }
    }
    isload = false;
    notifyListeners();
  }

  void addtochartbutton(int index, bool val) {
    listProduct[index].isaddtochart = val;
    notifyListeners();
  }

  // ໃຊ້ຕອນເພີ່ມເມນູ
  void setFoodMenuData(Product data, int number, int totalAmount, int size,
      int amount, int specailprice, String categoryname) {
    List<FoodMenuModel> foodData =
        foodMenuModel.where((element) => element.data.id == data.id).toList();

    ///  ຖ້າຍັງບໍ່ມີເມນູດັ່ງກ່າວ
    if (foodData.isEmpty) {
      foodMenuModel.add(FoodMenuModel(
          data: data,
          number: number,
          totalAmount: totalAmount,
          size: size,
          amount: amount,
          specialprice: specailprice,
          categoryname: categoryname));
    } else {
      for (var i in foodMenuModel) {
        if (i.data.id == data.id) {
          i.data = data;
          i.number = number;
          i.totalAmount = totalAmount;
          i.amount = amount;
          i.specialprice = specailprice;
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
  void deleteData(int index, int total) {
    _totalamount -= total;
    foodMenuModel.removeAt(index);
    notifyListeners();
  }

  void clearKitchenData() {
    _totalamount = 0;
    foodMenuModel = [];
    notifyListeners();
  }

//ສຳລັບການ ດຶງຂໍ້ມູນຂອງ ຂະໜາດອາຫານມາໂຊຢູ່ UI
  int _size = 0;
  int get size => _size;
  void setProductSize(int addsize, int index) {
    listProduct[index].size = addsize;
    _size = addsize;
    notifyListeners();
  }

  void addcount(int index) {
    listProduct[index].count++;
    notifyListeners();
  }

  void deletecount(int index) {
    listProduct[index].count--;
    notifyListeners();
  }

  void clearCount(int index) {
    listProduct[index].count = 0;
    notifyListeners();
  }

  void addcountdetailproduct(int index) {
    foodMenuModel[index].amount++;
    notifyListeners();
  }

  void deletecountdetail(int index) {
    foodMenuModel[index].amount--;
    notifyListeners();
  }
}
