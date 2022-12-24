// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/badrequest/validate_badrequest.dart';
import 'package:erp_pos/model/connect/connect_authorize_models.dart';
import 'package:erp_pos/model/connect/connect_create_tenant.dart';
import 'package:erp_pos/model/connect/connect_validate_user.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/services/connect/connect_authorize.dart';
import 'package:erp_pos/services/connect/create_tenant.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ConnectValidateModels?> connectvalidateuser(
    String email, BuildContext context, String name, String lastname) async {
  var logon = DateFormat('yyyy-MM-ddTkk:mm:ss').format(DateTime.now());
  var bytes = utf8.encode('P' + email + "L" + logon);
  var signature = md5.convert(bytes).toString();
  //var hsalogin =
  try {
    String url = APIPath.CONNECT_VALIDATE_USER;
    String data = jsonEncode({
      "email": email,
      "logon": logon,
      "name": "",
      "tennantId": "",
      "postype": "",
      "roleType": ""
    });
    var response = await http.post(Uri.parse(url), body: data, headers: {
          "accept": "text/plain",
          "signature": signature,
          "Content-Type": "application/json"
        },);
  
    // print('Reponse: ${response.body}');
 
    if (response.statusCode == 200) {
      return connectValidateModelsFromJson(response.body);
    } else if (response.statusCode == 400) {
      ConnectValidatModelBadRequest data =
          connectValidatModelBadRequestFromJson(response.body);
          

      /// ຖ້າບໍ່ມີຜູ້ໃຊ້ໃນລະບົບ
      if (data.code == "USERNAME_NOT_FOUND") {

        print("No user");

        AuthenticationProvider().registerUser(context, email, name, lastname);

      } else {
        //Navigator.pop(context);
        Mystyle().showAlertloadingError(context,"ແຈ້ງເຕືອນ!", "ກາລຸນາລອງໃໝ່ອີກຄັ້ງ");
        
      }
      return null;
    } else {
     // Navigator.pop(context);
Mystyle().showAlertloadingError(context,"ແຈ້ງເຕືອນ!", "ກາລຸນາລອງໃໝ່ອີກຄັ້ງ");
    }
  } catch (e) {
    // Navigator.pop(context);
    Mystyle().dialogError(context, "ແຈ້ງເຕືອນ", "ກາລຸນາລອງໃໝ່ອີກຄັ້ງ");

    /// show errr dialog
    rethrow;
  }
}
