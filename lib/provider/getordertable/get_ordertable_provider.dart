import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/detailordertable/detail_order_table.dart';
import 'package:erp_pos/services/ordertable/get_order_tableid_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetOrderTableProvider extends ChangeNotifier {
  GetOrderTableModels? _orderTableModels;
  GetOrderTableModels? get orderTableModels => _orderTableModels;
  List<GetOrderTable?> _ordertable = [];
  List<GetOrderTable?> get order => _ordertable;
  bool isloading = false;
  bool get loading => isloading;
  

  Future<List<GetOrderTable?>> getordertableprovider(
      BuildContext context, String idtable) async {
        isloading = true;
    _orderTableModels = await getordertableidservice(context, idtable);
    if (_orderTableModels != null) {
      _ordertable = _orderTableModels!.order!;

    }
    isloading = false;
    notifyListeners();
    return _ordertable;
  }
}
