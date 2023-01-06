import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/detailordertable/detail_order_table.dart';
import 'package:erp_pos/services/ordertable/get_order_tableid_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetOrderTableProvider extends ChangeNotifier {
  GetOrderTableModels? _orderTableModels;
  GetOrderTableModels? get orderTableModels => _orderTableModels;

  bool isloading = false;
  bool get loading => isloading;
  

  Future<void> getordertableprovider(
      BuildContext context, String idtable) async {
        isloading = true;
    _orderTableModels = await getordertableidservice(context, idtable);
    isloading = false;
    notifyListeners();

  }
}
