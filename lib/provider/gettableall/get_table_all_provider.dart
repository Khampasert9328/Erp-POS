// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/services/gettable/getalltable/get_all_table.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTableAllProvider extends ChangeNotifier {

  List<String> _idtable = [];
  List<String> get idtable => _idtable;
  GetTableModels? _tableModels;
  GetTableModels? get tableModels => _tableModels;
  bool _isload = false;
  bool get isloading => _isload;

  Future<void> gettableall(BuildContext context) async {
    _isload = true;
    String? idToken = await CountPre().getToken();

    _tableModels = await getTable(context, idToken, -1, 0);
    if (_tableModels != null) {
      for (var item in _tableModels!.table!) {
        _idtable.add(item.id!);
        
      }
      
    }
    _isload = false;
    notifyListeners();
  }
}
