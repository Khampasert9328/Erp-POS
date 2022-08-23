import 'package:erp_pos/pages/dasboard/dasboard.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:flutter/cupertino.dart';
import '../pages/Bill/bill.dart';

class Route {
  static const bill = '/dashboard';

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
    '/bill': (context) => Bill(),
    '/dashboard': (context) => Dasboard(),
    '/homepage':(context) => HomePage(),
  };
}
