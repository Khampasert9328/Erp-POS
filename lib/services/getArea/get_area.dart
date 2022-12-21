import 'dart:convert';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Future<AreaModels?> getArea() async {
  int? limit = -1;
  int? page = 0;
  String? idtoken = await CountPre().getToken();
  try {
    var url = '${APIPath.GET_AREA}/$limit/$page';
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idtoken',
      },
    );
    if (respones.statusCode == 200) {
      AreaModels areaModels = AreaModels.fromJson(json.decode(respones.body));
      return areaModels;
    }
  } catch (e) {}
}
