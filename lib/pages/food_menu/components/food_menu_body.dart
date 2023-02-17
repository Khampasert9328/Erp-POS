// ignore_for_file: unused_field, unused_import, use_key_in_widget_constructors, unnecessary_import, prefer_final_fields
import 'dart:ui';

import 'package:badges/badges.dart' as Badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/food_menu/components/search_food_menu.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:erp_pos/widget/add_food_type_dialog.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:erp_pos/widget/food_menu_card.dart';
import 'package:erp_pos/widget/place_to_eat_card.dart';
import 'package:erp_pos/widget/selected_menu_card.dart';
import 'package:erp_pos/widget/selected_menu_card_expand.dart';

class FoodMenuBody extends StatefulWidget {
  String tablename;

  FoodMenuBody({Key? key, required this.tablename}) : super(key: key);
  @override
  State<FoodMenuBody> createState() => _FoodMenuBodyState();
}

class _FoodMenuBodyState extends State<FoodMenuBody> {
  TextEditingController searchMenu = TextEditingController();
  PanelController panelController = PanelController();

  get cusicon => null;
  void toglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  void closepanel() => panelController.open();
  int amount = 50000;
  double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 90.0;
  bool isSelectedMenuCard = true;
  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Container(
          width: 150.w,
          height: 28.h,
          child: Marquee(
            blankSpace: 50,
            velocity: 150,
            pauseAfterRound: Duration(seconds: 2),
            text: 'ລາຍການອາຫານ',
            style: TextStyle(
                fontFamily: "Phetsarath-OT",
                color: AppTheme.BASE_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 21.sp),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return SearchDataMune();
                }));
              })
        ],
      ),
      body: SlidingUpPanel(
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
                            fontSize: 16.sp,
                            color: AppTheme.BASE_COLOR,
                            fontFamily: 'Phetsarath-OT',
                          ),
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
                                    fontFamily: 'Phetsarath-OT',
                                    color: AppTheme.BASE_COLOR),
                                text: 'ລວມລາຄາ: ',
                                children: <InlineSpan>[
                                  TextSpan(
                                    text:
                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppTheme.BASE_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        closepanel();
                      },
                      child: Container(
                        child: Badges.Badge(
                        
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
                          child: Icon(
                            Icons.shopping_cart,
                            size: 55,
                            color: AppTheme.BASE_COLOR,
                          ),
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
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Consumer<SwitchProvider>(
        builder: (context, value, child) {
          return !value.switchchang
              ? Center(
                  child: Text(
                  "ກະລຸນາເປີດກະກ່ອນ",
                  style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 16.sp,
                      color: Colors.grey),
                ))
              : FoodMenuCard();
        },
      ),
    );
  }

  Widget _panel() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: isSelectedMenuCard
          ? SelectedMenuCardExpand(
              tablename: widget.tablename,
              onNext: () async {
                setState(() {
                  isSelectedMenuCard = !isSelectedMenuCard;
                });
              },
              selectMenu: isSelectedMenuCard,
            )
          : PlaceToEatCard(
              tablename: widget.tablename,
              onback: () {
                setState(() {
                  isSelectedMenuCard = !isSelectedMenuCard;
                });
              },
            ),
    );
  }
}
