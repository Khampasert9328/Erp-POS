import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetData extends ChangeNotifier {
 
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
  String dateTime = 'dateTime';


  String _idtablestatus='';
  String _tablenamestatus='';
  String _idareastatus='';
  String _areanamestatus='';

  String get idtablestatus =>_idtablestatus;
  String get tablenamestatus => _tablenamestatus;
  String get idareastatus => _idareastatus;
  String get areanamestatus => _areanamestatus;

  

  void setIdTableStatus(String idtableS)async{
    _idtablestatus = idtableS;
    notifyListeners();

  }
  void setTBNameStatus(String tbname)async{
    _tablenamestatus = tbname;
    notifyListeners();
  }
  void setIdAreaStatus(String idArea)async{
    _idareastatus = idArea;
    notifyListeners();
  }
  void setAreaNameStatus(String NameArea)async{
    _areanamestatus = NameArea;
    notifyListeners();
  }

  void setDateTime(String date)async{
    dateTime = date;
    notifyListeners();
  }

  void setTableName(String name) async {
   _tablename = name;
    notifyListeners();
  }

  void setIdArea(String id) async{
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
