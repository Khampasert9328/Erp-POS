import 'package:dio/dio.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetOrderByIssuedateModels?> getorderbyissuedate() async {
  int limit = -1;
  int page = 0;
  String startdate = DateFormat('ddMMyyyy').format(DateTime.now());
  String startend = DateFormat('ddMMyyyy').format(DateTime.now());
  SharedPreferences pre = await SharedPreferences.getInstance();
  String? idToken = pre.getString("content");
  try {
    var url =
        "${APIPath.GET_ORDER_BY_ISSUE_DATE}/$limit/$page/$startdate/$startend";
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept':'text/plain',
        'Authorization':'Bearer $idToken'
      },
    );
    if (respones.statusCode==200) {
      return getOrderByIssuedateModelsFromJson(respones.body);
      
    }
  } catch (e) {
    print("error:$e");
  }
}
