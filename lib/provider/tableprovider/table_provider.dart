import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/services/gettable/get_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTableProvider extends ChangeNotifier {
  List<GetTable> _tablelist = [];
  List<GetTable> get gettablelist => _tablelist;
  Future<List<GetTable>> gettablebyid(BuildContext context, String? id) async {
    
    GetTableModels? models = await getTable(context, id);
   print("models:$models");
   
    if (models != null) {
      _tablelist = models.table!;
     for (var item in models.table!) {
       SharedPreferences preferences = await SharedPreferences.getInstance();
       preferences.setString("table", item.id!);
     }
      notifyListeners();
    }

   
    return _tablelist;
  }
}
