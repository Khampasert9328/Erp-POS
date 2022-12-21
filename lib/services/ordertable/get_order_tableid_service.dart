import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/utils/setdata/id_table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<GetOrderTableModels?> getordertableidservice(
    BuildContext context, String idtable) async {
  // String idtable = context.read<SetIdTable>().getidTable;
  String? idtoken = await CountPre().getToken();
  try {
    var url = '${APIPath.GET_ORDER_TABLE}/$idtable';
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        "accept":"text/plain",
        "Authorization":"Bearer $idtoken"
      },
    );
    if (respones.statusCode == 200) {
      return getOrderTableModelsFromJson(respones.body);
    }
  } catch (e) {
    print("error:$e");
  }
}
