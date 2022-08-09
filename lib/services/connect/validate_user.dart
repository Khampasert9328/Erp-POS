import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/connect_validate_user.dart';

Future<ConnectValidateModels?> connectvalidateuser(String email) async {
  try {
    Dio dio = Dio();

    String url = APIPath.CONNECT_VALIDATE_USER;
    String data = jsonEncode({
      "email": email,
      "logon": "",
      "name": "",
      "tennantId": "",
      "postype": "",
      "roleType": ""
    });
    var respones = await dio.post(url, data: data);
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
