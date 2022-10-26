

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<GetFoodMenuModels?> getfoodmenu()async{
  int limit = -1;
  int page = 0;
  bool removecahcs= true;
  String? idtoken = await CountPre().getToken();
  try {
    String url = "${APIPath.GET_FOOD_MENU}/$limit/$page/$removecahcs";
    var respones = await http.get(Uri.parse(url), headers: {
      "accept":"text/plain",
      "Authorization":"Bearer $idtoken"
    });
    if (respones.statusCode ==200) {
      return getFoodMenuModelsFromJson(respones.body);
    
    }
    
  } catch (e) {
    
  }
}