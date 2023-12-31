import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/deleteorder/deleteorder_many_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

Future<DeleteOrderManyModels?> deleteOrdermany(String orderid, String billid, String productsid, int size) async {
   String? idtoken = await CountPre().getToken();
  //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
  String yourToken = idtoken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);

  String userid = decodedToken['sub'];
  String domain = decodedToken['domain'];
  //////////////////////////////////////////////
  var ipA = IpAddress(type: RequestType.json);
  dynamic data = await ipA.getIpAddress();
  String ipaddress = data["ip"];
  String ipc = ipaddress.replaceAll(".", "");
  /////////////////////////////////////////////
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  String? computer = await androidInfo.model;
  try {
    var url = "${APIPath.DELETE_ORDER_MANY}";
    String playload = jsonEncode({
      "modified": 0,
      "modifiedID": userid,
      "ipAddress": ipc,
      "createID": userid,
      "created": 0,
      "computer": computer,
      "note": "none",
      "jobId": "none",
      "domain": domain,
      "orderId": orderid,
      "billId": billid,
      "products": [
        {
          "productId": productsid,
          "size": size,
        }
      ],
      "cancelDescription": "ຍົກເລີກອາຫານບາງປະເພດ",
      "cancelStatus": 2,
      "cancelUser": "N/A"
    });
    var respones = await http.post(
      Uri.parse(url),
      body: playload,
      headers: {
         "accept": "text/plain",
        "Authorization": "Bearer $idtoken",
        "Content-Type": "application/json",
      },
    );
    if (respones.statusCode==200) {
      return deleteOrderManyModelsFromJson(respones.body);
    }
  } catch (e) {
    rethrow;
  }
}
