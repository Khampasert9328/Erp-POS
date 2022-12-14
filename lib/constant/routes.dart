import 'package:erp_pos/pages/dasboard/dasboard.dart';
import 'package:erp_pos/pages/food_menu_detail/components/food_menu_detail_body.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/pages.dart';
import 'package:erp_pos/pages/table_detail/components/table_detail_body.dart';
import 'package:flutter/cupertino.dart';
import '../pages/Bill/bill.dart';

class Route {
  static const bill = '/dashboard';
   static const foodmenudetail = '/foodmenudetail';
   static const addfoodmenu = '/addfoodmenu';
  

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
    '/bill': (context) => Bill(),
    //'/dashboard': (context) => Dasboard(),
    '/homepage':(context) => HomePage(),
   // '/foodmenudetail':(context) => FoodMenuDetailBody(data: ,),
    '/addfoodmenu':(context) => AddFoodMenu(),
    
  };
}
