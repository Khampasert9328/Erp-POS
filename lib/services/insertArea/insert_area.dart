import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/area/insert_area_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<InsertAreaModels?> insertDataArea(String area) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idToken = preferences.getString("content");
  try {
    String url = APIPath.INSERT_AREA;
    String playload = jsonEncode({
      {
        "area": area,
        "status": "Activate",
        "metaData": {
          "modified": "",
          "modifiedID": "",
          "ipAddress": "",
          "createID": "",
          "created": "",
          "computer": "",
          "note": ""
        }
      }
    });
    var response = await http.post(Uri.parse(url), body: playload, headers: {
      "accept": "text/plain",
      "Authorization": "Bearer $idToken",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 200) {
       print(response.body);
    //  return insertAreaModelsFromJson(response.body);
     
    }
  } catch (e) {
    print(e);
  }
}
