import 'package:flutter/cupertino.dart';

class SetIdTable extends ChangeNotifier {
  String _idTable = '';
  String _tablename = '';
  String _billid = "";
  String _billNo = "";
  String _idarea = '';
  String areaname = '';
  String get idarea => _idarea;
  String get billNo => _billNo;
  String get billid => _billid;
  String get getidTable => _idTable;
  String get gettableName => _tablename;
  String get getareaname => areaname;

  void setTableName(String name) async {
    _tablename = name;
    notifyListeners();
  }

  void setIdArea(String id) {
    _idarea = id;
    notifyListeners();
  }

  void setAreaName(String nameArea) async {
    areaname = nameArea;
    notifyListeners();
  }

  void setIdTable(String id) {
    _idTable = id;
    notifyListeners();
  }
 

  void setBillid(String billid) {
    _billid = billid;
    notifyListeners();
  }

  void setBillNo(String billNo) {
    _billNo = billNo;
    notifyListeners();
  }
}
