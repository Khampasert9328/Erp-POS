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
import 'package:erp_pos/provider/bill/print_bill_provider.dart';
import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/createorder/create_order_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
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
  // ScrollController scrollController;
  VoidCallback onback;

  PlaceToEatCard({required this.onback});

  @override
  State<PlaceToEatCard> createState() => _PlaceToEatCardState();
}

class _PlaceToEatCardState extends State<PlaceToEatCard> {
  FoodMenuModel? model;
  TabController? controller;

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
                  GestureDetector(
                    onTap: widget.onback,
                    child: Container(
                      height: 50.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: AppTheme.WHITE_COLOR,
                        border: Border.all(color: AppTheme.BASE_COLOR),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ກັບຄືນ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.BASE_COLOR,
                               fontFamily: 'Phetsarath-OT',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(width: 15.w,),
                  GestureDetector(
                    onTap: () async {
                      if (context
                          .read<GetFoodMenuProvider>()
                          .getFoodMenuModel
                          .isEmpty) {
                        Mystyle().showDialogCheckData(
                            context, "ກາລຸນາກວດສອບອໍເດີຂອງທ່ານກ່ອນ");
                      } else {
                        String? tablename = await CountPre().getTableName();
                            

                        await CheckExpiredPackage()
                            .getCheckExpiredPackage(context)
                            .then((value) async {
                          PrintBillKitchenProvider().getprint();
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          String? getzone =
                              preferences.getString(CountPre().idzone);
                          SharedPreferences pri =
                              await SharedPreferences.getInstance();
                          String? billNo = pri.getString(CountPre().billNo);

                          try {
                            await SunmiPrinter.startTransactionPrint();
                            await SunmiPrinter.printText('ໃບບິນຫ້ອງຄົວ',
                                style: SunmiStyle(
                                    align: SunmiPrintAlign.CENTER,
                                    bold: true,
                                    fontSize: SunmiFontSize.LG));
                            await SunmiPrinter.line();

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(text: 'ໃບບິນເລກທີ', width: 6),
                              ColumnMaker(
                                  text: '$billNo',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(text: 'ວັນເວລາ', width: 6),
                              ColumnMaker(
                                  text:
                                      '${DateFormat("yyy-MM-dd HH:mm").format(DateTime.now())}',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(text: 'ໂຊນ ຫຼື ພື້ນທີ່', width: 6),
                              ColumnMaker(
                                  text: '${getzone ?? "ສັ່ງກັບບ້ານ"}',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(text: 'ເລກໂຕະ', width: 6),
                              ColumnMaker(
                                  text: '${tablename ?? "ສັ່ງກັບບ້ານ"}',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.line();
                            await SunmiPrinter.printText('ລາຍການອາຫານ',
                                style: SunmiStyle(
                                    align: SunmiPrintAlign.CENTER,
                                    bold: true,
                                    fontSize: SunmiFontSize.MD));

                            for (var data in context
                                .read<GetFoodMenuProvider>()
                                .getFoodMenuModel) {
                              await SunmiPrinter.printRow(cols: [
                                ColumnMaker(
                                    text: '${data.data.name}', width: 6),
                                ColumnMaker(
                                    text:
                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(data.number)} x ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(data.totalAmount)}',
                                    width: 6,
                                    align: SunmiPrintAlign.RIGHT),
                              ]);
                            }
                            await SunmiPrinter.line();

                            await SunmiPrinter.printText('ຂໍຂອບໃຈ',
                                style: SunmiStyle(
                                    align: SunmiPrintAlign.CENTER,
                                    bold: true,
                                    fontSize: SunmiFontSize.MD));
                            await SunmiPrinter.lineWrap(3);
                            await SunmiPrinter.submitTransactionPrint();
                            await SunmiPrinter.exitTransactionPrint();
                          } catch (e) {
                            print("error:$e");
                          }
                        });

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CalculateMoney(
                              tablename: tablename ?? "ບໍ່ມີໂຕະ",
                            ),
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
                indicatorPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                indicatorWeight: 3.0,
                indicatorColor: AppTheme.BASE_COLOR,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 18.sp,
                   fontFamily: 'Phetsarath-OT',
                ),
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
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
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
