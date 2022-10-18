import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetTableModels?> getTable(BuildContext context, String? idtoken, int limit, int page) async {
  int limit = -1;
  int page = 0;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idToken = preferences.getString("content");
  try {
    String url = "${APIPath.GET_TABLE}/$limit/$page";

    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idToken',
      },
    );
    if (respones.statusCode == 200) {
      return getTableModelsFromJson(respones.body);
    }
  } catch (e) {}
}
