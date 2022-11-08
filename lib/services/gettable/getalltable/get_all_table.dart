import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/gettableall/gettable_all_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetTableAll?> getTable(BuildContext context, String? idtoken, int limit, int page) async {
  int limit = -1;
  int page = 0;
  String? idtoken = await CountPre().getToken();
  try {
    String url = "${APIPath.GET_TABLE}/$limit/$page";

    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idtoken',
      },
    );
    if (respones.statusCode == 200) {
      return getTableAllFromJson(respones.body);
    }
  } catch (e) {}
}
