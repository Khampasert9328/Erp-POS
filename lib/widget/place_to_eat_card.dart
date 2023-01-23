// ignore_for_file: unused_import, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously, unnecessary_string_interpolations
import 'dart:ui';

import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/pages/table_detail/components/table_detail_body.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';

import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/createorder/create_order_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/checkexpiredpackage/check_expired_package_service.dart';
import 'package:erp_pos/services/updatestatus/updatestatus_service.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/calculate_money.dart';
import 'package:erp_pos/widget/eat_resturant.dart';
import 'package:erp_pos/widget/order_to_take_home.dart';
import 'package:erp_pos/widget/selected_menu_card.dart';
import 'package:erp_pos/widget/selected_menu_card_expand.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceToEatCard extends StatefulWidget {
  VoidCallback onback;

  PlaceToEatCard({
    required this.onback,
  });

  @override
  State<PlaceToEatCard> createState() => _PlaceToEatCardState();
}

class _PlaceToEatCardState extends State<PlaceToEatCard>
    with SingleTickerProviderStateMixin {
  FoodMenuModel? model;
  TabController? controller;
  PrinterStatus? _printerStatus;
  PrinterMode? _printerMode;
  TabController? _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);

    _bindingPrinter().then((bool isBind) async => {
          if (isBind)
            {
              _getPrinterStatus(),
              _printerMode = await _getPrinterMode(),
            }
        });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  /// must binding ur printer at first init in app
  Future<bool> _bindingPrinter() async {
    final bool result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  /// you can get printer status
  Future<void> _getPrinterStatus() async {
    final PrinterStatus result = await SunmiPrinter.getPrinterStatus();
    setState(() {
      _printerStatus = result;
    });
  }

  Future<PrinterMode> _getPrinterMode() async {
    final PrinterMode mode = await SunmiPrinter.getPrinterMode();
    return mode;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 100.h,
          child: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 14.h),
                          primary: AppTheme.BASE_COLOR,
                        ),
                        onPressed: widget.onback,
                        child: Text(
                          'ກັບຄືນ',
                          style: TextStyle(
                            fontFamily: 'Phetsarath-OT',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ),
                 
                  GestureDetector(
                    onTap: () async {
                      if (context
                          .read<GetFoodMenuProvider>()
                          .getFoodMenuModel
                          .isEmpty) {
                        Mystyle().showDialogCheckData(
                            context, "ກາລຸນາກວດສອບອໍເດີຂອງທ່ານກ່ອນ");
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                child: SizedBox(
                                  height: 200.h,
                                  width: 100.w,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Image.asset(
                                        ERPImages.logotokitchen,
                                        height: 104.h,
                                        width: 104.w,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "ອໍເດີກຳລັງສົ່ງໄປຫ້ອງຄົວ",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: AppTheme.BASE_COLOR),
                                      ),
                                    ],
                                  )),
                                ),
                              );
                            });

                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pop(context);
                        context
                            .read<CheckExpiredPackage>()
                            .getCheckExpiredPackage(context);
                        String areaid = context.read<AreaProvider>().idarea;
                        await context
                            .read<AreaProvider>()
                            .callTable(context, areaid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CalculateMoney(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: AppTheme.BASE_COLOR,
                        border: Border.all(color: AppTheme.BASE_COLOR),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ສົ່ງຫ້ອງຄົວ",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.WHITE_COLOR),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              TabBar(
                controller: _tabController,
                indicatorPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                indicatorWeight: 3.0,
                indicatorColor: AppTheme.BASE_COLOR,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Phetsarath-OT',
                ),
                onTap: ((value) {
                  if (value == 1) {
                   CountPre().setTableId("none");
                  }
                  else{
                    print("value==$value");
                  }
                }),
                tabs: const [
                  Tab(
                    text: 'ກິນຢູ່ຮ້ານ',
                  ),
                  Tab(
                    text: 'ສັ່ງກັບບ້ານ',
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    EatResturant(),
                    OrderToTakeHome(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
