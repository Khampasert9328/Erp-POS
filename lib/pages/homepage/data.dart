import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/bill/bill.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/pages/homepage/models/homepage_bottom_bar.dart';
import 'package:erp_pos/pages/order/order.dart';
import 'package:erp_pos/pages/table/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 
class HomePageData {

  static List<Widget> pages = <Widget>[
    
  
    POSTable(),
    FoodMenu(),
    Bill(),
  ];

  static List<HomePageBottomBarModel> homePageBottomBar = [
    // HomePageBottomBarModel(title: 'ພາບລວມ', icon: ERPImages.dashboard),
    HomePageBottomBarModel(title: 'ໂຕະ', icon: ERPImages.table),
    HomePageBottomBarModel(title: 'ເມນູອາຫານ', icon: ERPImages.menu),
    // HomePageBottomBarModel(title: 'ອໍເດີ', icon: ERPImages.order),
    HomePageBottomBarModel(title: 'ໃບບິນ', icon: ERPImages.bill),
  ];
}
