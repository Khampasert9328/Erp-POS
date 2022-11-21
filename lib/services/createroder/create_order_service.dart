// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously, unused_import, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/pages/table/components/textdatetime.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<CreateOrderModels?> createOrder(
    BuildContext context, String dateexpired, String datesup) async {
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
    var dateSup = partsup.sublist(0).join('').trim();

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
    String? tableid = await CountPre().getTableId();
    List<Map<String, dynamic>> products = [];

    var ipA = IpAddress(type: RequestType.json);
    dynamic data = await ipA.getIpAddress();
    String ipaddress = data["ip"];
    String ipc = ipaddress.replaceAll(".", "");

    DateTime time = DateTime.now();
    String issueDate = DateFormat('yyyyMMdd').format(time);
    String date = DateFormat('dd-MM-yyyy HH:mm:ss').format(time);

    for (var item in context.read<GetFoodMenuProvider>().getFoodMenuModel) {
      products.add({
        "productId": "${item.data.id}",
        "name": "${item.data.name}",
        "size": 0,
        "amount": item.totalAmount,
        "priceSale": item.data.pricesale,
        "priceImport": item.data.priceimport,
        "discount": 0,
        "freeamount": 0,
        "description": "none",
        "cooked": true,
        "timeCooked": "none",
        "categoryOrder": {
          "categoryId": "${item.data.categoryid}",
          "categoryName": "none"
        }
      });
    }
    var url = "${APIPath.CREATE_ORDER}";
    String payload = jsonEncode({
      "order": {
        "id": "none",
        "issueDate": "$issueDate",
        "date": date,
        "billId": "none",
        "tableId": tableid ?? 'none',
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
          "ipAddress": ipc,
          "createID": "$userid",
          "created": 0,
          "computer": "$computer",
          "note": "none",
          "jobId": "none"
        }
      },
      "bill": {
        "id": "none",
        "prefixid": "none",
        "issuedate": "$issueDate",
        "date": date,
        "discount": 0,
        "total_price": 0,
        "paid": 0,
        "credit": 0,
        "customerid": "none",
        "paymentMethod": 0,
        "timeReport": "none",
        "time": "none",
        "domain": "$domain",
        "metaData": {
          "modified": 0,
          "modifiedID": "$userid",
          "ipAddress": ipc,
          "createID": "$userid",
          "created": 0,
          "computer": "$computer",
          "note": "none",
          "jobId": "none"
        }
      },
      "packageDateStart": "$rmDate",
      "packageDateEnd": "$rmDash"
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
      CreateOrderModels models = createOrderModelsFromJson(respones.body);
      return models;
    }
  } catch (e) {
    print("error1:$e");
  }
}
