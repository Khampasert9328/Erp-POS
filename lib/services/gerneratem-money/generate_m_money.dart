import 'dart:convert';
import 'dart:math';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/generateqrmmoney/generateqrmmoney.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

Future<GenerateQrMmoney?> generatemmneyservice(BuildContext context, String accountnumber, String walletid) async {
  try {
    var random = Random();
    int min = 0;
    int max = 120000;
    var supfix = min + random.nextInt(max - min);
    //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
    String? idtoken = await CountPre().getToken(); //
    String yourToken = idtoken!;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    String username = decodedToken['name'];
    String? amount = context.read<GetFoodMenuProvider>().totalamont.toString();

    print("username:$accountnumber");
    print("wallet_id:$walletid");

    var url = APIPath.GENERATE_MMONEY;
    String playload = jsonEncode({
      "tranid":
          "bill-${DateFormat("yyyyMMddHHmmss").format(DateTime.now())}${supfix}",
      "username": "$accountnumber",
      "fee": "0",
      "amount": "$amount",
      "wallet_ids": "$walletid",
      "topic": "none"
    });

    var respones = await http.post(
      Uri.parse(url),
      headers: {
        "accept": "text/plain",
        "Authorization": "Bearer $idtoken",
        "Content-Type": "application/json"
      },
      body: playload,
    );

    if (respones.statusCode == 200) {
      return generateQrMmoneyFromJson(respones.body);
    }
  } catch (e) {
    print("errormmoney:$e");
  }
}
