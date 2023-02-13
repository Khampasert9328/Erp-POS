// ignore_for_file: use_build_context_synchronously

import 'package:erp_pos/model/updatestatus/updatestatus_models.dart';
import 'package:erp_pos/model/updatetable/update_table_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/services/updatestatus/updatestatus_service.dart';
import 'package:erp_pos/services/updatetable/update_table_service.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTableProvider extends ChangeNotifier {
  UpdateStatusModels? _tableUpdateModels;
  UpdateStatusModels? get tableupdateModels => _tableUpdateModels;
  int? _status;
  int? get status => _status;

  Future<void> updateTableProvider(BuildContext context, String? tableid,
      String? tablename, String? idarea, String? areaname) async {
    _tableUpdateModels =
        await updateTableService(context, tableid, tablename, idarea, areaname);
    notifyListeners();
  }

  Future<void> updatetableStatus(BuildContext context) async {
    String? tablename1 = await CountPre().getTableName();
    String? tableid1 = await CountPre().getTableId();
    String? area1 = await CountPre().getArea();
    String? areaid1 = await CountPre().getAreaId();
    _tableUpdateModels =
        await updateStatus(context, areaid1, area1, tableid1, tablename1);
    if (_tableUpdateModels != null) {
      String idarea = context.read<AreaProvider>().idarea;
     context.read<AreaProvider>().callTable(context, idarea);
       Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
    }
    notifyListeners();
  }
}
