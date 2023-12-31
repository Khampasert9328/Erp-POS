import 'dart:convert';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/createsessoin/create_sessoin_models.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
Future<CreateSession?> createSession(int cash, BuildContext context) async {
  String? idtoken = await CountPre().getToken();
  //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
  String yourToken = idtoken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String username = decodedToken['name'];
  String userid = decodedToken['sub'];
  try {
    var url = '${APIPath.CREATE_SESSION}';
    String payload = jsonEncode({
      "userOpen": userid,
      "userOpenName": username,
      "openDate": DateFormat('yyyyMMddhhmmss').format(DateTime.now()),
      "cashOpen": 0
    });
    var respones = await http.post(
      Uri.parse(url),
      headers: {
        "accept":"text/plain",
        "Authorization":"Bearer $idtoken",
        "Content-Type":"application/json"
      },
      body: payload,
    );
    if (respones.statusCode == 200) {
      return createSessionFromJson(respones.body);
    }
   
  } catch (e) {
    print("error:$e");
  }
}
