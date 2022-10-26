import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/foodmenu/food_menu_posttype_models.dart';
import 'package:erp_pos/services/getfoodmenu/get_food_menu_services.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<GetFoodMenuPostTypeModels?> getfoodmenutype() async {
  int limit = 20;
  int page = 1;
  bool removecahcs = true;
  String? idtoken = await CountPre().getToken();
  //ວິທີການເເຕກເອົາຂໍ້ມູນໃນ token
  String yourToken = idtoken!;
  Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
  String postType = decodedToken['postype'];
  ////////////////////////////////////////////////////////////////////////
  try {
    String url =
        "${APIPath.GET_FOOD_MENU_POSTTYE}/$limit/$page/$postType/$removecahcs";
    var respones = await http.get(Uri.parse(url),
        headers: {"accept": "text/plain", "Authorization": "Bearer $idtoken"});
   
    if (respones.statusCode == 200) {
      return getFoodMenuPostTypeModelsFromJson(respones.body);
    }else if(respones.statusCode == 400){
      GetFoodMenuPostTypeModels data = getFoodMenuPostTypeModelsFromJson(respones.body);
    if (data.code == 'all') {
      getfoodmenu();
    }
    }
  } catch (e) {}
}
