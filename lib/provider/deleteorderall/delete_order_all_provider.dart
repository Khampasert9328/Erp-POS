import 'package:erp_pos/model/deleteorderall/delete_order_all_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/services/deleteorderall/delete_orderall_service.dart';
import 'package:erp_pos/utils/loading.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteOrderAllProvider extends ChangeNotifier {
  DeleteOrderAllModels? _deleteOrderAllModels;
  DeleteOrderAllModels? get deleteOrderAllModels => _deleteOrderAllModels;

  Future<void> deleteOrderAllProvider(
      BuildContext context, String billid, String orderid) async {
    _deleteOrderAllModels = await deleOrderAll(billid, orderid);
    notifyListeners();
  }
}
