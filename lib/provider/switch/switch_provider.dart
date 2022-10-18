import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchProvider extends ChangeNotifier {
  bool switchang = false;
  void changSwitch({bool toggle = true}) async {
    toggle = switchang;
    notifyListeners();
  }
}
