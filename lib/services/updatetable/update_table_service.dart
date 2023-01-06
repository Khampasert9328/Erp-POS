import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/model/updatestatus/updatestatus_models.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';

import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/updatetable/update_table_models.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

Future<UpdateStatusModels?> updateTableService(BuildContext context, String? tableid,String? tablename,String? idarea,String? areaname) async {
  String? idToken = await CountPre().getToken();


  ///ແຕກຂໍ້ມູນໃນ Token
  String yourToken = idToken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String userid = decodedToken['sub'];
  String domain = decodedToken['domain'];
//get ip ຂອງເຄື່ອງ
  var ipA = IpAddress(type: RequestType.json);
  dynamic data = await ipA.getIpAddress();
  String ipaddress = data["ip"];
  String ipc = ipaddress.replaceAll(".", "");

//get device ຂອງເຄື່ອງ
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  String? computer = await androidInfo.model;
  try {
    var url = "${APIPath.UPDATE_TABLE}";
    String playload = jsonEncode({
      "id": "$tableid",
      "name": "$tablename",
      "status": 1,
      "status_av": 0,
      "mergeTable": {
        "tableId": "none",
        "tableName": "none",
      },
      "tableArea": {
        "id": "$idarea",
        "area": "$areaname",
      },
      "metaData": {
        "modified": 0,
        "modifiedID": "$userid",
        "ipAddress": "$ipc",
        "createID": "$userid",
        "created": 0,
        "computer": "$computer",
        "note": "none",
        "jobId": "none",
        "domain": "$domain"
      },
      "domain": "$domain",
      "revision": "none"
    });
    var respones = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json'
      },
      body: playload,
    );
    if (respones.statusCode == 200) {
      return updateStatusModelsFromJson(respones.body);
    }
  } catch (e) {
    rethrow;
  }
}
