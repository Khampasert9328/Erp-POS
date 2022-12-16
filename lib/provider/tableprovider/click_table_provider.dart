import 'package:flutter/cupertino.dart';

class ClickTableProvider extends ChangeNotifier {
  bool _click = false;
  bool get click => _click;

  void clickTableProvider(bool clickfirsttime) async {
    _click = clickfirsttime;
    notifyListeners();
  }

  void clearbool()async{
    _click = false;
    notifyListeners();
  }
}
