
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getaccount/getaccount_models.dart';
import 'package:http/http.dart' as http;

Future<GetAccountModels?> getAccountService(
    int limit, int page, String idtoken) async {
  try {
    var url = "${APIPath.GET_ACCOUNT}/$limit/$page";
    var respones = await http.get(Uri.parse(url), headers: {
      "accept":"text/plain",
      "Authorization":"Bearer $idtoken"
    });
    if (respones.statusCode==200) {
      return getAccountModelsFromJson(respones.body);
    }
  } catch (e) {

  }
}
