import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
     SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setString(_tablename, name);
    notifyListeners();
  }

  void setIdArea(String id) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setString(_idarea, _idarea);
    notifyListeners();
  }

  void setAreaName(String nameArea) async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setString(areaname, nameArea);
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

  Future<String?> getAreaname()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.getString(areaname);
    notifyListeners();
  }
  Future<String?> getAreaId()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.getString(_idarea);
    notifyListeners();
  }
}
