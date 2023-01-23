import 'dart:convert';

import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/detailordertable/detail_order_table.dart';
import 'package:erp_pos/pages/food_menu/models/food_menu_data_model.dart';
import 'package:erp_pos/services/ordertable/get_order_tableid_service.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetOrderTableProvider extends ChangeNotifier {
  GetOrderTableModels? _orderTableModels;
  GetOrderTableModels? get orderTableModels => _orderTableModels;
  List<GetOrderTableModels> _listOrderTable = [];
  List<GetOrderTableModels> get listOrderTable => _listOrderTable;

  bool isloading = false;
  bool get loading => isloading;

  Future<void> getordertableprovider(
      BuildContext context, String idtable) async {
    try {
      _listOrderTable.clear();
      isloading = true;
      _orderTableModels = await getordertableidservice(context, idtable);
      if (_orderTableModels != null) {
        List<Order> listorder = await CountPre().getUpdateOrder();
        for (var i in listorder) {
          if (_orderTableModels!.order!.first!.tableid == i.tableid) {
            _listOrderTable.removeWhere((element) =>
                element.order!.first!.tableid ==
                _orderTableModels!.order!.first!.tableid);
            for (var j in i.product!) {
              _orderTableModels!.order!.first!.product!.add(j);
            }
            orderTableModels!.order!.first!.product!.removeAt(0);
          }
        }
        _listOrderTable.add(_orderTableModels!);
      }
      isloading = false;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
