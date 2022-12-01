import 'package:erp_pos/model/updatetable/update_table_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/services/updatetable/update_table_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateTableProvider extends ChangeNotifier {

  TableUpdateModels? _tableUpdateModels;
  TableUpdateModels? get tableupdateModels => _tableUpdateModels;
  int? _status;
  int? get status => _status;

  Future<void> updateTableProvider(BuildContext context)async{
    _tableUpdateModels = await updateTableService();
    if (_tableUpdateModels !=null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const HomePage()), (route) => false); 
    }

  }
  
}