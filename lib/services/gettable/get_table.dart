// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<GetTableModels?> getTablebyid(BuildContext context, String id) async {
 String? idtoken = await CountPre().getToken();
 

  try {
    String url = "${APIPath.GET_TABLE_BY_AREAID}/$id";

    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'text/plain',
        'Authorization': 'Bearer $idtoken',
      },
    );
    if (respones.statusCode == 200) {
      return getTableModelsFromJson(respones.body);
    }
  } catch (e) {}
   

  
}
