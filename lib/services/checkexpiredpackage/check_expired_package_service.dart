import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/checkexpiredpackage/check_expired_package.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<CheckExpiredPackageMedels?> checkExpiredPackage() async {
  String? idtoken = await CountPre().getToken();
  try {
    var url = "${APIPath.CHECK_EXPIRED_PACKAGE}";
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept':'text/plain',
        'Authorization':'Bearer $idtoken'
      },
    );
    if (respones.statusCode==200) {
     
      return checkExpiredPackageMedelsFromJson(respones.body);
      
    }
  } catch (e) {}
}
