import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaProvider extends ChangeNotifier {
  List<String> _areaID= [];
  List<String>? get getAreaID => _areaID;
  List<Area> _areaList = [];
  List<Area> get getAreaList => _areaList;
  Future<List<Area>> getZone() async {
    AreaModels? areaModels = await getArea();

    if (areaModels != null) {
      _areaList = areaModels.area!;
      for (var item in areaModels.area!) {
        _areaID.add(item.id!.toString());
     
       
      }

    }
    notifyListeners();
    return _areaList;
  }
}
