import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodMenuProvider extends ChangeNotifier {
  bool _show = true;
 
  int _totalAmount = 0;
  bool get show => _show;

  int get getTotalAmount => _totalAmount;

  void showbutton(bool isshow) {
    _show = isshow;
    notifyListeners();
  }

  ///ເພີ່ມຄ່າລາຄາລວມ
  void addTotalamount(int amount) async {
    _totalAmount += amount;
    notifyListeners();
  }

  



 

 
}
