import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/constant/data.dart';
import 'package:erp_pos/model/connect/connect_token_models.dart';
import 'package:erp_pos/widget/style.dart';

import 'package:flutter/cupertino.dart';

Future<ConnectTokenModels?> connectToken(
    String username, String password, BuildContext context) async {
  try {
    Dio dio = Dio();
    String url = APIPath.CONNECT_TOKEN;
    String data = jsonEncode({
      "clientID": ContstantData.clientID,
      "secret": ContstantData.secret,
      "grantType": ContstantData.grantType,
      "scope": ContstantData.scope,
      "username": username,
      "password": password + '@8Erp',
      "redirectUri": ContstantData.redirectUri
    });
    var respones = await dio.post(url, data: data);

    if (respones.statusCode == 200) {
      return connectTokenModelsFromJson(respones.data);
    }else{
      Mystyle().showdialogError(context);
      
    }
  } catch (e) {}
}
