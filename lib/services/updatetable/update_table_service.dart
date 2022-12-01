import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/updatetable/update_table_models.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<TableUpdateModels?> updateTableService() async {
  String? idToken = await CountPre().getToken();
  String? tableId = await CountPre().getTableId();
  String? tableName = await CountPre().getTableName();
  String? areaId = await CountPre().getAreaId();
  String? areaname = await CountPre().getArea();
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
      "id": "$tableId",
      "name": "$tableName",
      "status": 0,
      "status_av": 0,
      "mergeTable": {
        "tableId": "$tableId",
        "tableName": "$tableName",
      },
      "tableArea": {
        "id": "$areaId",
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
      return tableUpdateModelsFromJson(respones.body);
    }
  } catch (e) {
    print("errorUpdatetable:$e");
  }
}
