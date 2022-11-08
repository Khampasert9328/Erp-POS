import 'dart:convert';
import 'dart:math';

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/generateqrmmoney/generateqrmmoney.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

Future<GenerateQrMmoney?> generatemmneyservice(BuildContext context) async {
  var random = Random();
  int min = 0;
  int max = 120000;
  var supfix = min + random.nextInt(max + min);
  String? idtoken = await CountPre().getToken();
  //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
  String yourToken = idtoken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String username = decodedToken['name'];
  String? amount = context.read<GetFoodMenuProvider>().totalamont.toString();

  var url = APIPath.GENERATE_MMONEY;
  String playload = jsonEncode({
    "tranid":
        "bill-${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}${supfix}",
    "username": username,
    "fee": "0",
    "amount": amount,
    "wallet_ids": 2191783261,
    "topic": "none"
  });

  var respone = await http.post(
    Uri.parse(url),
    body: playload,
  );
  if (respone.statusCode == 200) {
    return generateQrMmoneyFromJson(respone.body);
  }
}
