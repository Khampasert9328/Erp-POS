import 'dart:convert';

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<CreatePaymentCashModels?> createpaymentcash(
    String billid,
    int total,
    String sessionid,
    String packagestart,
    String packageend,
    int paymenttype) async {
  
  String? idtoken = await CountPre().getToken();
  try {
    var url =
        "${APIPath.PAYMENT_CASH}/$billid/$total/$sessionid/$packagestart/$packageend/$paymenttype";

    var respones = await http.post(
      Uri.parse(url),
      headers: {
        "accept": "text/plain",
        "Authorization": "Bearer $idtoken",
      },
    );
    if (respones.statusCode == 200) {
      return createPaymentCashModelsFromJson(respones.body);
    }
  } catch (e) {
    rethrow;
  }
}
