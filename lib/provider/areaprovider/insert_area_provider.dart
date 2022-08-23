import 'package:erp_pos/model/area/insert_area_models.dart';
import 'package:erp_pos/services/insertArea/insert_area.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';

class InsertAreaProvider extends ChangeNotifier {
  Future<void> addDataArea(String area, BuildContext context)async{
    try {
      InsertAreaModels? insertAreaModels = await insertDataArea(area);
    if (insertAreaModels != null) {
     print("insert:$insertAreaModels");
    }
    } catch (e) {
      print("e:$e");
    }
  }
}