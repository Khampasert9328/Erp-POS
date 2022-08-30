import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/foodmenu/food_menu_posttype_models.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<GetFoodMenuPostTypeModels?> getfoodmenutype() async {
  int limit = 20;
  int page = 1;
  bool removecahcs = true;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idToken = preferences.getString("content");
  //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
  String yourToken = idToken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String postType = decodedToken['postype'];
  ////////////////////////////////////////////////////////////////////////
  try {
    String url = "${APIPath.GET_FOOD_MENU_POSTTYE}/$limit/$page/$postType/$removecahcs";
    var respones = await http.get(Uri.parse(url),
        headers: {"accept": "text/plain", "Authorization": "Bearer $idToken"});
    if (respones.statusCode == 200) {
      return getFoodMenuPostTypeModelsFromJson(respones.body);
    }
  } catch (e) {}
}
