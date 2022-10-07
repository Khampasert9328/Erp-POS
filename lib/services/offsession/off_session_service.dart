// ignore_for_file: unrelated_type_equality_checks
import 'dart:convert';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/offsession/off_session_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<OffSesionModels?> createoffsession() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idtoken = preferences.getString("content");
  //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
  String yourToken = idtoken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String username = decodedToken['name'];

  String? idsession = preferences.getString(CountPre().sessoinid);
  // print("idsession:$idsession");
  //  print("username:$username");
  //  print("token:$idtoken");

  try {
    var url = APIPath.OFF_SESSION;
    String playload = jsonEncode({
      "id": "$idsession",
      "closeDate": DateFormat('yyyyMMddhhmmss').format(DateTime.now()),
      "cashCount": 0,
      "userClose": "N/A",
      "userCloseName": username,
      "remark": "N/A"
    });
    print("playload:$playload");
    var respones = await http.post(
      Uri.parse(url),
      body: playload,
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idtoken',
        'Content-Type': 'application/json'
      },
    );
    print("res:${respones.statusCode}");
    if (respones == 200) {
      OffSesionModels models =
          OffSesionModels.fromJson(jsonDecode(respones.body));
      return models;
    }
  } catch (e) {
    print("ErrorOffSession:$e");
  }
}
