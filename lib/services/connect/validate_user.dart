import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/connect/connect_validate_user.dart';
import 'package:intl/intl.dart';

Future<ConnectValidateModels?> connectvalidateuser(String email) async {
  var logon = DateFormat('yyyy-MM-ddTkk:mm:ss').format(DateTime.now());
  var bytes = utf8.encode('P' + email + "L" + logon);
  var signature = md5.convert(bytes).toString();
  //var hsalogin =
  try {
    Dio dio = Dio();
    String url = APIPath.CONNECT_VALIDATE_USER;
    String data = jsonEncode({
      "email": email,
      "logon": signature,
      "name": "",
      "tennantId": "",
      "postype": "",
      "roleType": ""
    });
    var respones = await dio.post(url,
        data: data, options: Options(headers: {"application/json": signature}));
    //ການກວດສອບຂໍ້ມູນ
    if (respones.statusCode == 200) {
      return connectValidateModelsFromJson(respones.data);
    } else {
      /// pop
      /// show dialog err
      return null;
    }
  } catch (e) {
    return null;
  }
}
