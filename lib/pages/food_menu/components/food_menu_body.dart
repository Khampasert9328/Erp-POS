// ignore_for_file: unused_field, unused_import, use_key_in_widget_constructors, unnecessary_import, prefer_final_fields

import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:erp_pos/widget/add_food_type_dialog.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:erp_pos/widget/food_menu_card.dart';
import 'package:erp_pos/widget/place_to_eat_card.dart';
import 'package:erp_pos/widget/selected_menu_card.dart';
import 'package:erp_pos/widget/selected_menu_card_expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:erp_pos/constant/routes.dart' as custom_route;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FoodMenuBody extends StatefulWidget {
  @override
  State<FoodMenuBody> createState() => _FoodMenuBodyState();
}

class _FoodMenuBodyState extends State<FoodMenuBody> {
  TextEditingController searchMenu = TextEditingController();
  PanelController panelController = PanelController();
  void toglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  // List<String> foodType = [
  //   'ເຂົ້າລາດໜ້າ',
  //   'ເຄື່ອງດື່ມ',
  //   'ນ້ຳ',
  // ];

  // String selectedFoodType = 'ເຂົ້າລາດໜ້າ';
  int amount = 50000;
  double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  bool isSelectedMenuCard = true;
  @override
  Widget build(BuildContext context) {

    _panelHeightOpen = MediaQuery.of(context).size.height*.80;

    return Stack(
      children: [
        SlidingUpPanel(
          
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          controller: panelController,
          backdropEnabled: true,
          panel: _panel(),
          collapsed: Container(
            decoration: BoxDecoration(
              color: AppTheme.WHITE_COLOR,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        toglePanel();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        height: 10.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                            color: AppTheme.GREY_COLOR,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ລາຍການອາຫານ',
                            style: TextStyle(
                                fontSize: 16.sp, color: AppTheme.BASE_COLOR),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          StatefulBuilder(
                            builder: (context, setState) =>
                                Consumer<FoodMenuProvider>(
                              builder: (context, value, child) => Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppTheme.BASE_COLOR),
                                  text: 'ລວມລາຄາ: ',
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppTheme.BASE_COLOR,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Badge(
                          badgeContent: Text(
                            context
                                .watch<GetFoodMenuProvider>()
                                .getFoodMenuModel
                                .length
                                .toString(),
                            style: TextStyle(
                              color: AppTheme.WHITE_COLOR,
                            ),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            size: 55,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          //panelBuilder: (sc) => _panel(sc),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          body: buildBody(context),
        ),
      ],
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Text(
            'ລາຍການອາຫານ',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ERPTextfield(
                      controller: searchMenu, hintText: 'ຄົ້ນຫາອາຫານ')),
              SizedBox(
                width: 15.w,
              ),
              IconButton(
                  onPressed: () {
                    //
                  },
                  icon: Icon(
                    Icons.search,
                    size: (45.w + 45.h) / 2,
                  ))
            ],
          ),
          Expanded(
            child: Consumer<SwitchProvider>(
              builder: (context, value, child) {
                return !value.switchchang
                    ? Center(
                        child: Text(
                        "ກາລຸນາເປີກກະກ່ອນ",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ))
                    : FoodMenuCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: isSelectedMenuCard
          ? SelectedMenuCardExpand(
              onNext: () async {
                setState(() {
                  isSelectedMenuCard = !isSelectedMenuCard;
                });
              },
              selectMenu: isSelectedMenuCard,
            )
          : PlaceToEatCard(
              onback: () {
                setState(() {
                  isSelectedMenuCard = !isSelectedMenuCard;
                });
              },
            ),
    );
  }
}
