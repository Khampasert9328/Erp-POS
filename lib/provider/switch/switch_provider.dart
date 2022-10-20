import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchProvider extends ChangeNotifier {
  bool _switchang = false;
  bool get switchchang => _switchang;
  void changSwitch(bool val) async {
    _switchang = val;
    notifyListeners();
  }
}
