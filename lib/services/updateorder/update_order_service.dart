// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously, unused_import, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/createOrderMore/create_order_more.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/updateorder/update_order_models.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/pages/table/components/textdatetime.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<CreateOrderAgainModles?> updateorder1(
    BuildContext context,
    String dateexpired,
    String datesup,
    String? tableid,
    String billid,
    String orderid,
    int index,
    int size,
    String productid) async {
  try {
    var str = "$dateexpired";
    var parts = str.split(' ');
    var prefix = parts[0].trim(); // prefix: "date"
    var rmDash = prefix.replaceAll('-', '');
    var dateExp = parts.sublist(0).join('').trim();

    var strsup = "$datesup";
    var partsup = strsup.split(' ');
    var prefixsup = partsup[0].trim();
    var rmDate = prefixsup.replaceAll("-", ''); // prefix: "date"

    String? idtoken = await CountPre().getToken();
    //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
    String yourToken = idtoken!;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    String username = decodedToken['name'];
    String userid = decodedToken['sub'];
    String domain = decodedToken['domain'];
////////////////////////////////////////////////////////////////////////////

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String? computer = await androidInfo.model;
    // String? billNo = await CountPre().getBillNo();
    List<Map<String, dynamic>> products = [];

    var ipA = IpAddress(type: RequestType.json);
    dynamic data = await ipA.getIpAddress();
    String ipaddress = data["ip"];
    String ipc = ipaddress.replaceAll(".", "");
    DateTime time = DateTime.now();
    String issueDate = DateFormat('yyyyMMdd').format(time);
    String date = DateFormat('dd-MM-yyyy HH:mm:ss').format(time);

    for (var data in context
        .read<GetOrderByIssueDateProvider>()
        .order!
        .order!
        .first
        .product!) {
      int productIndex = products
          .indexWhere((element) => element['productid'] == data.productid);
      if (productIndex > -1 && products[productIndex]['size'] == data.size) {
        products.removeAt(index);
        // products
        //     .removeWhere((element) => element['productid'] == data.productid);
      }
    }
    var url = "${APIPath.UPDATE_ORDER_More}";
    String payload = jsonEncode({
      "id": "$orderid",
      "issueDate": "$issueDate",
      "date": "$date",
      "billId": "$billid",
      "tableId": "$tableid",
      "tableid": "$tableid",
      "product": products,
      "userId": "$username",
      "description": {
        "customerName": "none",
        "contact": ["none"],
        "village": "none",
        "district": "none",
        "province": "none"
      },
      "status": 0,
      "domain": "$domain",
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
      "isSelected": true,
      "packageDateStart": "$rmDate",
      "packageDateEnd": "$rmDash",
      "select": true
    });

    var respones = await http.post(
      Uri.parse(url),
      headers: {
        "accept": "text/plain",
        "Authorization": "Bearer $idtoken",
        "Content-Type": "application/json"
      },
      body: payload,
    );

    if (respones.statusCode == 200) {
      CreateOrderAgainModles? models =
          CreateOrderAgainModles.fromJson(jsonDecode(respones.body));
      return models;
    }
  } catch (e) {
    rethrow;
  }
}
