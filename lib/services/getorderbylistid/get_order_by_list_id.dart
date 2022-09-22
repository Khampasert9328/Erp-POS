import 'dart:convert';

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getorderbylistid/get_order_by_list_id_models.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<GetOrderByListId?> getorderbylistid(String? id) async {
  int limit = -1;
  int page = 0;
  String startdate = DateFormat('ddMMyyyy').format(DateTime.now());
  String startend = DateFormat('ddMMyyyy').format(DateTime.now());
  SharedPreferences pre = await SharedPreferences.getInstance();
  String? idToken = pre.getString("content");
  try {
    var url = "${APIPath.GET_ORDER_BY_LIST_ID}/$id";
    var payload = jsonEncode({
      {
        "id": [id],
        "limit": limit,
        "page": page,
        "packagestartdate": startdate,
        "packageenddate": startend
      }
    });

    var respones = await http.post(Uri.parse(url), body: payload, headers: {
      "accept":"text/plain",
      "Authorization":"Bearer $idToken",
      "Content-Type":"application/json"
    });

    if (respones.statusCode==200) {
      return getOrderByListIdFromJson(respones.body);
      
    }
  } catch (e) {
    print("error:$e");
  }
}
