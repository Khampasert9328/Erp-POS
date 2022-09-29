import 'dart:convert';

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/constant/data.dart';
import 'package:erp_pos/model/connect/connect_token_models.dart';
import 'package:erp_pos/model/refreshtoken/refresh_token_models.dart';
import 'package:http/http.dart' as http;

Future<ConnectTokenModels?> refreshtoken(String refreshtoken) async {
  try {
    var url = "${APIPath.REFRESH_TOKEN}";
    String payload = jsonEncode({
      {
        "clientID": ContstantData.clientID,
        "secret": ContstantData.secret,
        "refreshToken": refreshtoken
      }
    });
    var respones = await http.post(
      Uri.parse(url),
      body: payload,
      headers: {"accept": "text/plain", "Content-Type": "application/json"},
    );
    if (respones == 200) {
      return connectTokenModelsFromJson(respones.body);
    }
  } catch (e) {
    print("ErrorRefreshToken:$e");
  }
}
