import 'package:flutter/cupertino.dart';

class ListTableProvider extends ChangeNotifier {

  List<String> _itemtable = [];
  List<String> get itemtable => _itemtable;
  void addTable(String name){
    _itemtable.add( name);
    notifyListeners();
  }

  void deleteTable(int index){
    _itemtable.removeAt(index);
    notifyListeners();
  }
  
}