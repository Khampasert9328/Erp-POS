import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/model/getorderbylistid/get_order_by_list_id_models.dart';
import 'package:erp_pos/pages/order/order.dart';
import 'package:erp_pos/services/getorderbyissuedate/get_order_by_issuedate_service.dart';
import 'package:erp_pos/services/getorderbylistid/get_order_by_list_id.dart';
import 'package:flutter/cupertino.dart';

class GetOrderByIssueDateProvider extends ChangeNotifier {

  List<GetOrder> listorder = [];
  List<GetOrder> get _listorder => listorder;


  Future<List<GetOrder>?> getorderfromservice()async{

    GetOrderByIssuedateModels? order=await getorderbyissuedate();

    if (order != null) {
    String billid = order.order!.first.billid!;
    GetOrderByListId? getOrderByListId = await getorderbylistid(billid);
    if (getOrderByListId!=null) {
      print("get info success");
    }
    }


  }
  
}