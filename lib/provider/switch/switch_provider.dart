import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchProvider extends ChangeNotifier {
  bool switchang = false;
  void changSwitch({bool toggle = true}) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    String? id = pre.getString(CountPre().sessoinid);
    if (id==0) {
      toggle = switchang;
    }
    
    notifyListeners();
  }
}
