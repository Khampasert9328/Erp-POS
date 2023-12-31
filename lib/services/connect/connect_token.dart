import 'dart:convert';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/constant/data.dart';
import 'package:erp_pos/model/connect/connect_token_models.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
Future<ConnectTokenModels?> connectToken(
    String email, String password, BuildContext context) async {
  try {
    String url = APIPath.CONNECT_TOKEN;
    String data = jsonEncode({
      "clientID": ContstantData.clientID,
      "secret": ContstantData.secret,
      "grantType": ContstantData.grantType,
      "scope": ContstantData.scope,
      "username": email,
      "password": '$password@8Erp',
      "redirectUri": ContstantData.redirectUri
    });

    var respones = await http.post(
      Uri.parse(url),
      body: data,
      headers: {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      },
    );
    if (respones.statusCode == 200) {
      CountPre().setConnectTokenResponse(respones.body);
      return connectTokenModelsFromJson(respones.body);
    } else {
      
    }
  } catch (e) {
   rethrow;
  }
}
