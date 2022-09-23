import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/pages/bill/bill.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/pages/homepage/models/homepage_bottom_bar.dart';
import 'package:erp_pos/pages/table/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageData {
  static const List<Widget> pages = <Widget>[
    // Icon(
    //   Icons.call,
    //   size: 150,
    // ),
    POSTable(),
    FoodMenu(),
    Bill(),
    // Icon(
    //   Icons.camera,
    //   size: 150,
    // ),
    // Icon(
    //   Icons.chat,
    //   size: 150,
    // ),
  ];

  static List<HomePageBottomBarModel> homePageBottomBar = [
    // HomePageBottomBarModel(title: 'ພາບລວມ', icon: ERPImages.dashboard),
    HomePageBottomBarModel(title: 'ໂຕະ', icon: ERPImages.table),
    HomePageBottomBarModel(title: 'ເມນູອາຫານ', icon: ERPImages.menu),
    // HomePageBottomBarModel(title: 'ອໍເດີ', icon: ERPImages.order),
    HomePageBottomBarModel(title: 'ໃບບິນ', icon: ERPImages.bill),
  ];
}
