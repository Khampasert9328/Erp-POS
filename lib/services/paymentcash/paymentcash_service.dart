import 'dart:convert';

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<CreatePaymentCashModels?> createpaymentcash(
    String billid,
    int number,
    String sessionid,
    String packagestart,
    String packageend,
    int paymenttype) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idtoken = preferences.getString("content");
  try {
    var url =
        "${APIPath.PAYMENT_CASH}/$billid/$number/$sessionid/$packagestart/$packageend/$paymenttype";

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
