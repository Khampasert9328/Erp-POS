import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodMenuProvider extends ChangeNotifier {
  bool _show = false;
  bool get show => _show;

  int _totalAmount = 0;

  int get getTotalAmount => _totalAmount;

  ///ເພີ່ມຄ່າລາຄາລວມ
  void addTotalamount(int amount) async {
    _totalAmount += amount;
    notifyListeners();
  }

  int? count = 0;
  int? get counter => count;
  void increment(int add) async {
    count = add;
    notifyListeners();
  }

  void remove(int re) async {
    count = re;
    notifyListeners();
  }

  void clearAmount(){
    count = 0;
    notifyListeners();
  }
}
