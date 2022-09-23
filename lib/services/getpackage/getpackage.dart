import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getpackage/package_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetPackageModels?> getPackage() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? packageid = preferences.getString(CountPre().packageId);
    SharedPreferences pre = await SharedPreferences.getInstance();
    String? idToken = pre.getString("content");

    var url = '${APIPath.GET_PACKAGE}/$packageid';
    var respones = await http.get(Uri.parse(url), headers: {
      "accept": "text/plain",
      "Authorization": "Bearer $idToken",
    });
    if (respones.statusCode==200) {
      return getPackageModelsFromJson(respones.body);
    }
  } catch (e) {
    print("error:$e");
  }
}
