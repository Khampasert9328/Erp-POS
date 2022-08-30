

import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<GetFoodMenuModels?> getfoodmenu()async{
  int limit = 20;
  int page = 1;
  bool removecahcs= true;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idToken = preferences.getString("content");
  try {
    String url = "${APIPath.GET_FOOD_MENU}/$limit/$page/$removecahcs";
    var respones = await http.get(Uri.parse(url), headers: {
      "accept":"text/plain",
      "Authorization":"Bearer $idToken"
    });
    if (respones.statusCode ==200) {
      return getFoodMenuModelsFromJson(respones.body);
    
    }
    
  } catch (e) {
    
  }
}