// ignore_for_file: use_build_context_synchronously, unused_import, depend_on_referenced_packages

import 'dart:convert';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetOrderByIssuedateModels?> getorderbyissuedate(int limit, int page,
    String idToken, String? startdate, String? startend, BuildContext context) async {
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
    rethrow;
  }
}
