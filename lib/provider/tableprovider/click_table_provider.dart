import 'package:flutter/cupertino.dart';

class ClickTableProvider extends ChangeNotifier {
  bool _click = false;
  bool get click => _click;
  bool _firstOrderMore = true;
  bool get firstOrderMore => _firstOrderMore;

  void clickTableProvider(bool clickfirsttime) async {
    _click = clickfirsttime;
    notifyListeners();
  }
  void firsOrderMoreTB(bool val){
    _firstOrderMore = val;
    notifyListeners();
  }
  void clearFirstOrder(){
    _firstOrderMore = false;
    notifyListeners();
  }

  void clearbool()async{
    _click = false;
    notifyListeners();
  }
}
