import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/getsesion/get_sessoin_models.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetSessoin?> getsessionservice() async {
  int status = 0;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idToken = preferences.getString("content");
  String yourToken = idToken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String userId = decodedToken['sub'];
  try {
    var url = "${APIPath.GET_SESSION}/$userId/$status";
    var respones = await http.get(
      Uri.parse(url),
      headers: {
        "accept":"text/plain",
        "Authorization":"Bearer $idToken"
      },
    );
    if (respones.statusCode == 200) {
      return getSessoinFromJson(respones.body);
      
    }
  } catch (e) {
    print("error:$e");
    
  }
}
