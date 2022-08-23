import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/connect/connect_create_tenant.dart';
import 'package:http/http.dart' as http;

Future<ConnectCreateTenantModels?> connectCreateTenantModel(
    String name, String lastname, String? id, String? accessToken) async {
  try {
    String url = APIPath.CONNECT_CREATE_TENANT;
    String data = jsonEncode({
      "id": id,
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
    var response = await http.post(Uri.parse(url), body: data, headers: {
      'Content-Type': 'application/json',
      'accept': 'text/plain',
      'Authorization': 'Bearer $accessToken'
    });
   
    if (response.statusCode == 200) {
      return connectCreateTenantModelsFromJson(response.body);
    }
    return null;
  } catch (e) {
    return null;
  }
}
