import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetOrderByIssuedateModels?> getorderbyissuedate() async {
  int? limit = -1;
  int? page = 0;
  String? startdate = DateFormat('ddMMyyyy').format(DateTime.now());
  String? startend = DateFormat('ddMMyyyy').format(DateTime.now());
  SharedPreferences pre = await SharedPreferences.getInstance();
  String? idToken = pre.getString("content");
  // print("startdate:${startdate}");
  // print("startend:${startend}");
  // print("startend:${idToken}");
  try {
    var url =
        "${APIPath.GET_ORDER_BY_ISSUE_DATE}/$limit/$page/$startdate/$startend";
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idToken',
      },
    );
    if (respones.statusCode == 200) {
      GetOrderByIssuedateModels models = GetOrderByIssuedateModels.fromJson(
        jsonDecode(respones.body),
      );
      return models;
    }
  } catch (e) {
    print("error:$e");
  }
}
