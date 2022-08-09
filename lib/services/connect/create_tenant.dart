import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/connect/connect_create_tenant.dart';

Future<ConnectCreateTenantModels?> connectCreateTenantModel(
  String name,
  String lastname,
) async {
  try {
    Dio dio = Dio();
    String url = APIPath.CONNECT_CREATE_TENANT;
    String data = jsonEncode({
      "id": '',
      "name": name,
      "firstname": '',
      "lastname": lastname,
      "country": '',
      "province": '',
      "district": '',
      "village": '',
      "address": '',
      "contact": '',
      "status": ''
    });
    var respones = await dio.post(url, data: data);
    if (respones.statusCode == 200) {
      return connectCreateTenantModelsFromJson(respones.data);
    }
    return null;
  } catch (e) {
    return null;
  }
}
