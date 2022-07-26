import 'package:flutter/cupertino.dart';
import '../pages/Bill/bill.dart';

class Route {
  static const bill = '/bill';

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
    '/bill': (context) => Bill(),
  };
}
