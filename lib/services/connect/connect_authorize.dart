import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/connect/connect_authorize_models.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<ConnectAuthorizeModels?> connectAuthorizeModels(
    String email, BuildContext context) async {
  try {
    var _logon = DateFormat('yyyy-MM-ddTkk:mm:ss').format(DateTime.now());
    var bytes = utf8.encode('P' + email + "L" + _logon);
    var signature = md5.convert(bytes).toString();
    Dio dio = Dio();
    String url = APIPath.CONNECT_ATHORIZE;

    String data = jsonEncode({
      "email": email,
      "logon": _logon,
      "name": "",
      "tennantId": "",
      "postype": '',
      "roleType": ''
    });

    var respones = await dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          "accept": "text/plain",
          "signature": signature,
          "Content-Type": "application/json",
        },
      ),
    );
    if (respones.statusCode == 200) {
      return connectAuthorizeModelsFromJson(respones.data);
    }
  } catch (e) {}
}
