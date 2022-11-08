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
import 'package:get_ip_address/get_ip_address.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<CreateOrderModels?> createOrder(BuildContext context) async {
  try {
    String? dateexpired = await CountPre().getDateExpired();
    String? datesup = await CountPre().getDateSupscribe();
    SharedPreferences tableid = await SharedPreferences.getInstance();
    String? tableid1 = tableid.getString(CountPre().tableid);

    var str = "$dateexpired";
    var parts = str.split(' ');
    var prefix = parts[0].trim(); // prefix: "date"
    var rmDash = prefix.replaceAll('-', '');
    var dateExp = parts.sublist(0).join('').trim();
    
    

    

    var strsup = "$datesup";
    var partsup = strsup.split(' ');
    var prefixsup = partsup[0].trim();
    var rmDate = prefixsup.replaceAll("-", '');// prefix: "date"
    var dateSup = partsup.sublist(0).join('').trim();

    String? idtoken = await CountPre().getToken();
    //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
    String yourToken = idtoken!;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    String username = decodedToken['name'];
    String userid = decodedToken['sub'];
    String domain = decodedToken['domain'];
////////////////////////////////////////////////////////////////////////////
    var ipAddress = IpAddress(type: RequestType.json);
    var ip = await ipAddress.getIpAddress();
    var ipa = '$ip';
    var ip1 = ipa.split('.');
    var ip2 = ip1[0].trim(); // prefix: "date"
    var ip3 = ip1.sublist(0).join('').trim();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String? computer = await androidInfo.model;
    String? billNo = await CountPre().getBillNo();
    List<Map<String, dynamic>> products = [];

    for (var item in context.read<GetFoodMenuProvider>().getFoodMenuModel) {
      products.add({
     "productId": "${item.data.id}",
        "name": "${item.data.name}",
        "size": 0,
        "amount": "${item.totalAmount}",
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
          "categoryId": item.data.categoryid,
          "categoryName": item.data.name
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
        "tableId": "${tableid1 ?? "none"}",
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
          "ipAddress": "$ip3",
          "createID": "$userid",
          "created": 0,
          "computer": "$computer",
          "note": "Order Food"
        }
      },
      "bill": {
        "id": "string",
        "prefixid": "none",
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
        "domain": "$domain",
        "metaData": {
          "modified": 0,
          "modifiedID": "$userid",
          "ipAddress": "$ip3",
          "createID": "$userid",
          "created": 0,
          "computer": "$computer",
          "note": "Order Food"
        }
      },
      "packageDateStart": "${rmDash}",
      "packageDateEnd": "${rmDate}",
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
      return createOrderModelsFromJson(respones.body);
    }
  } catch (e) {
    print("error:$e");
  }
}
