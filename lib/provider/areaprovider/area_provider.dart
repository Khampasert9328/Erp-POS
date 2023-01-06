import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:erp_pos/services/gettable/get_table.dart';
import 'package:erp_pos/services/gettable/getalltable/get_all_table.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

class AreaProvider extends ChangeNotifier {
  List<String>? _areaID = [];
  List<String>? get getAreaID => _areaID;
  AreaModels? _areaModels;
  AreaModels? get areaModels => _areaModels;
  Area? _areaList;
  Area? get getAreaList => _areaList;
  bool isloading = false;
  bool get isload => isloading;
  GetTableModels? _tablelist;
  GetTableModels? get gettablelist => _tablelist;
  

  Future<void> getZone(BuildContext context) async {
    isloading = true;
      int? index =await CountPre().getIndexArea();
    _areaModels = await getArea();
    if (_areaModels != null) {
      //ຖ້າວ່າ id ມັນບໍ່ມີຄ່າວ່າງແລ້ວໃຫ້ມັນດຶງຂໍ້ມູນໂຕະມາສະແດງ
      if (_areaModels!.area!.isNotEmpty) {
        _tablelist = await getTablebyid(context, _areaModels!.area!.first.id!);
      }
    }
    isloading = false;
    notifyListeners();
  }
  
//ຟັງຊັ້ນໃນການດຶງຂໍ້ມູນໂຕະເວລາເຮາກົດ ຊັ້ນ ແລ້ວໃຫ້ມັນສົ່ງ id ຂອງຊັ້ນ
  Future<void> callAPITable(BuildContext context, String id,) async {
    isloading = true;
     int? index =await CountPre().getIndexArea();
    _tablelist = await getTablebyid(context, id);
    isloading=false;
    notifyListeners();
  }

  //ຂໍຂໍ້ມູນໂຕະ
  Future<void> callTable(BuildContext context)async{
      isloading = true;
    int? index =await CountPre().getIndexArea();
    _tablelist = await getTablebyid(context, _areaModels!.area![index!].id!);
     isloading=false;
    notifyListeners();
  }
}
