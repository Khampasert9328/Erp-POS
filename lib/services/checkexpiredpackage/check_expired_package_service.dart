import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/checkexpiredpackage/check_expired_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<CheckExpiredPackageMedels?> checkExpiredPackage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idToken = preferences.getString("content");
  try {
    var url = "${APIPath.CHECK_EXPIRED_PACKAGE}";
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        'accept':'text/plain',
        'Authorization':'Bearer $idToken'
      },
    );
    if (respones.statusCode==200) {
      return checkExpiredPackageMedelsFromJson(respones.body);
      
    }
  } catch (e) {}
}
