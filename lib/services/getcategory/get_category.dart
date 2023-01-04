import 'dart:convert';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Future<GetCategoryModels?> getCategory() async {
  int? limit = -1;
  int? page = 0;
  bool removecah = true;
  String? idtoken = await CountPre().getToken();
  try {
    var url = '${APIPath.GET_CATEGORY}/$limit/$page/$removecah';
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idtoken',
      },
    );
    if (respones.statusCode == 200) {
      GetCategoryModels areaModels = GetCategoryModels.fromJson(json.decode(respones.body));
      return areaModels;
    }
  } catch (e) {}
}
