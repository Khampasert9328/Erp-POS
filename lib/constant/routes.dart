import 'package:erp_pos/pages/dasboard/dasboard.dart';
import 'package:erp_pos/pages/pages.dart';
import 'package:flutter/cupertino.dart';

class Route {
  static const bill = '/bill';
  static const dashboard = '/dashboard';
  static const addFoodMenu = '/addFoodMenu';
  static const foodMenuDetail = '/foodMenuDetail';

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
    '/bill': (context) => Bill(),
    '/dashboard': (context) => Dasboard(),
    '/addFoodMenu': (context) => AddFoodMenu(),
    '/foodMenuDetail': (context) => FoodMenuDetail(),
  };
}
