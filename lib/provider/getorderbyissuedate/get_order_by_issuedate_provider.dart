// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_nullable, unused_import, unused_local_variable

import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/model/getorderbylistid/get_order_by_list_id_models.dart';
import 'package:erp_pos/model/gettableall/gettable_all_models.dart';
import 'package:erp_pos/model/order/order_models.dart';

import 'package:erp_pos/services/getorderbyissuedate/get_order_by_issuedate_service.dart';
import 'package:erp_pos/services/getorderbylistid/get_order_by_list_id.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetOrderByIssueDateProvider extends ChangeNotifier {
  List<String> listID = [];

  GetOrderByIssuedateModels? _order;
  bool _isload = false;
  bool get isloading => _isload;
  GetOrderByIssuedateModels? get order => _order;
  GetOrderByListId? _getOrderByListId;
  GetOrderByListId? get getOrderByListId => _getOrderByListId;
  String? billid;
  String? get _billid => billid;
  Future<void> getorderfromservice(
    BuildContext context,
  ) async {
    _isload = true;
    SharedPreferences pre = await SharedPreferences.getInstance();

    String? idToken = await CountPre().getToken();
    DateTime time = DateTime.now();
    String? startdate = await CountPre().getDateTimebill();
    String? startend = await CountPre().getDateTimebill();

    DateTime timenow = DateTime.now();
    var startDnow = "$timenow";
    var stDnow = startDnow.split(" ");
    var staDnow = stDnow[0].trim();
    var timnow = staDnow.replaceAll("-", "");

    String? startDate = await CountPre().getDateSupscribe();
    var startD = "$startDate";
    var stD = startD.split(" ");
    var staD = stD[0].trim();
    var tstaD = staD.replaceAll("-", "");
    String? endDate = await CountPre().getDateExpired();
    var endD = "$endDate";
    var senD = endD.split(" ");
    var end1D = senD[0].trim();
    var tendD = end1D.replaceAll("-", "");

    _order = await getorderbyissuedate(
        -1, 0, idToken!, startdate ?? timnow, startend ?? timnow, context);

    if (_order != null) {
      for (var item in _order!.order!) {
        listID.add(item.billid!);
        billid = item.billid;
        CountPre().setBillId(item.billid.toString());
      }
      _getOrderByListId = await getorderbylistid(listID, -1, 0, tstaD, tendD);
    }
    _isload = false;
    notifyListeners();
  }

  void deleteOrder(int index) {
    _order!.order!.first.product!.removeAt(index);
    notifyListeners();
  }
}
