import 'package:erp_pos/model/createOrderMore/create_order_more.dart';
import 'package:erp_pos/model/deleteorder/delete_order_all_models.dart';
import 'package:erp_pos/model/deleteorder/deleteorder_many_models.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/services/deleteorder/delete_orderall_service.dart';
import 'package:erp_pos/services/deleteorder/deleteorder_many_service.dart';
import 'package:erp_pos/services/updateorder/update_order_service.dart';
import 'package:erp_pos/utils/loading.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteOrderAllProvider extends ChangeNotifier {
  CreateOrderAgainModles? _updateOrderBill;
  DeleteOrderManyModels? _deleteOrderManyModels;
  DeleteOrderAllModels? _deleteOrderAllModels;
  DeleteOrderAllModels? get deleteOrderAllModels => _deleteOrderAllModels;
  DeleteOrderManyModels? get deleteOrderManyModels => _deleteOrderManyModels;
  CreateOrderAgainModles? get updateOrderBill => _updateOrderBill;
  bool isloading = false;

  Future<void> deleteOrderAllProvider(
      BuildContext context, String billid, String orderid) async {
    isloading = true;
    _deleteOrderAllModels = await deleOrderAll(billid, orderid);
    isloading = false;
    notifyListeners();
  }

  Future<void> deleteOrderManyProvider(
      String orderid, String billid, String productsid, int size) async {
    isloading = true;
    _deleteOrderManyModels =
        await deleteOrdermany(orderid, billid, productsid, size);
    isloading = false;
    notifyListeners();
  }

  Future<void> updateOrderProvider(BuildContext context, String tableid,
      String billid, String orderid, int index,  String productid,int size, )async {
    String? dateexpired = await CountPre().getDateExpired();
    String? datesup = await CountPre().getDateSupscribe();
    isloading = true;
    _updateOrderBill = await updateorder1(
        context, dateexpired!, datesup!, tableid, billid, orderid, index, size, productid);
    
    isloading = false;
    notifyListeners();
  }
}
