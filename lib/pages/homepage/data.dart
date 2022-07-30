import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/pages/homepage/models/homepage_bottom_bar.dart';
import 'package:erp_pos/pages/table/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageData{
  static const List<Widget> pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    POSTable(),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  static  List<HomePageBottomBarModel> homePageBottomBar = [
    HomePageBottomBarModel(title: 'ພາບລວມ', icon: POSImages.dashboard),
    HomePageBottomBarModel(title: 'ໂຕະ', icon: POSImages.table),
    HomePageBottomBarModel(title: 'ເມນູອາຫານ', icon: POSImages.menu),
    HomePageBottomBarModel(title: 'ອໍເດີ', icon: POSImages.order),
    HomePageBottomBarModel(title: 'ໃບບິນ', icon: POSImages.bill),
  ];
}