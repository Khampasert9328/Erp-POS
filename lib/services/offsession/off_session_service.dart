// ignore_for_file: unrelated_type_equality_checks
import 'dart:convert';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/createoffsession/createoffsession_models.dart';
import 'package:erp_pos/model/getsesion/get_sessoin_models.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<CreateOffSessionModels?> createoffsession(BuildContext context, String id, String closeDate, int cashCount, String userclose, String userName) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idtoken = preferences.getString("content");
 
 

  try {
    var url = APIPath.OFF_SESSION;
    String playload = jsonEncode({
      "id": id,
      "closeDate": DateFormat('yyyyMMddhhmmss').format(DateTime.now()),
      "cashCount": 0,
      "userClose": userName,
      "userCloseName": userName,
      "remark": "N/A"
    });
    var respones = await http.post(
      Uri.parse(url),
      body: playload,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idtoken',
        'Content-Type': 'application/json'
      },
    );
   // print("res23:${respones.statusCode}");
    if (respones == 200) {
     
      return createOffSessionModelsFromJson(respones.body);
    }
  } catch (e) {
    print("ErrorOffSession:$e");
  }
}
