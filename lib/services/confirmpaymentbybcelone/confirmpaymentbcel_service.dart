import 'dart:convert';

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<CreatePaymentCashModels?> confirmpaymentbybcelone(
  BuildContext context,
    String billid,
    String sessionid,
    String packagestart,
    String packageend,
    int paymenttype, int totalamont) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idtoken = preferences.getString("content");
  
  try {
    var url =
        "${APIPath.PAYMENT_CASH}/$billid/$totalamont/$sessionid/$packagestart/$packageend/$paymenttype";

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
