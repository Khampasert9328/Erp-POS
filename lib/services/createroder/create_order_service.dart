// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously, unused_import, depend_on_referenced_packages

import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/createordermodel/create_order_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/pages/table/components/textdatetime.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<CreateOrderModels?> createOrder(BuildContext context) async {
  try {
    SharedPreferences pre = await SharedPreferences.getInstance();
    String? idToken = pre.getString("content");
    SharedPreferences pre1 = await SharedPreferences.getInstance();
    String? dateexpired = pre1.getString(CountPre().dateExpired);
    SharedPreferences pre2 = await SharedPreferences.getInstance();
    String? datesup = pre2.getString(CountPre().dateSubscribe);
    SharedPreferences tableid = await SharedPreferences.getInstance();
    String? tableid1 = tableid.getString(CountPre().tableid);

    var str = "$dateexpired";
    var parts = str.split('-');
    var prefix = parts[0].trim(); // prefix: "date"
    var dateExp = parts.sublist(0).join('').trim();

    var strsup = "$datesup";
    var partsup = str.split('-');
    var prefixsup = partsup[0].trim(); // prefix: "date"
    var dateSup = partsup.sublist(0).join('').trim();


    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? idtoken = preferences.getString("content");
    //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
    String yourToken = idToken!;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    String username = decodedToken['name'];
    String userid = decodedToken['sub'];
    String domain = decodedToken['domain'];
////////////////////////////////////////////////////////////////////////////
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String ip = androidInfo.device!; // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    SharedPreferences pri = await SharedPreferences.getInstance();
    String? billNo = pri.getString(CountPre().billNo);
    List<Map<String, dynamic>> products = [];

    for (var item in context.read<GetFoodMenuProvider>().getFoodMenuModel) {
      products.add({
        "productId": "${item.data.id}",
        "name": "${item.data.name}",
        "size": 0,
        "amount": item.totalAmount,
        "priceSale": context
            .read<GetFoodMenuProvider>()
            .getFoodMenuModel
            .first
            .data
            .pricesale,
        "priceImport": item.data.priceimport,
        "discount": 0,
        "freeamount": 0,
        "description": "string",
        "cooked": true,
        "timeCooked": "string",
        "categoryOrder": {
          "categoryId": "${item.data.categoryid}",
          "categoryName": "string",
        }
      });
    }

    var url = "${APIPath.CREATE_ORDER}";
    String payload = jsonEncode({
      "order": {
        "id": "string",
        "issueDate": "${DateFormat("yyyMMdd").format(DateTime.now())}",
        "date": "${DateFormat("yyy-MM-dd HH:mm:ss").format(DateTime.now())}",
        "billId": "string",
        "tableId": "$tableid1",
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
          "modified":
              '${DateFormat("yyyMMdd HH:mm:ss").format(DateTime.now())}',
          "modifiedID": "$userid",
          "ipAddress": "string",
          "createID": "$userid",
          "created": 0,
          "computer": "string",
          "note": "Order Food"
        }
      },
      "bill": {
        "id": "string",
        "prefixid": billNo,
        "issuedate": "${DateFormat("yyyMMdd").format(DateTime.now())}",
        "date": "${DateFormat("yyy-MM-dd HH:mm:ss").format(DateTime.now())}",
        "discount": 0,
        "total_price": 0,
        "paid": 0,
        "credit": 0,
        "customerid": "string",
        "paymentMethod": 0,
        "timeReport": "string",
        "time": "string",
        "domain": "string",
        "metaData": {
          "modified": 0,
          "modifiedID": "$userid",
          "ipAddress": "string",
          "createID": "$userid",
          "created": 0,
          "computer": "string",
          "note": "Order Food"
        }
      },
      "packageDateStart": "${dateSup}",
      "packageDateEnd": "${dateExp}",
    });
    var respones = await http.post(Uri.parse(url),
        headers: {
          "accept": "text/plain",
          "Authorization": "Bearer $idToken",
          "Content-Type": "application/json"
        },
        body: payload);

    if (respones.statusCode == 200) {
      CreateOrderModels data = createOrderModelsFromJson(respones.body);
      if (data == 'billNo') {}
      return createOrderModelsFromJson(respones.body);
    }
  } catch (e) {
    print("error:$e");
  }
}
