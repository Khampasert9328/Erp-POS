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
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/checkexpiredpackage/check_expired_package_service.dart';
import 'package:erp_pos/services/updatestatus/updatestatus_service.dart';
import 'package:erp_pos/utils/check_status.dart';
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
  String tablename;

  PlaceToEatCard({
    required this.onback,
    required this.tablename
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
                              builder: (_) => CalculateMoney(tablename: widget.tablename,),
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
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AreaProvider>(
              builder: ((context, value, child) {
                if (value.areaModels == null) {
                  return const Text("ບໍ່ມີຂໍ້ມູນ");
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: value.areaModels!.area!.length,
                              itemBuilder: (context, index) {
                                String idArea =
                                    value.areaModels!.area![index].id ?? '';
                                String beforeID = value.idarea;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  context
                                                      .read<AreaProvider>()
                                                      .setAreaID(idArea);
                                                  setState(() {
                                                    selectIndex = index;

                                                    context
                                                        .read<AreaProvider>()
                                                        .callAPITable(
                                                          context,
                                                          idArea,
                                                        );
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        right: 8,
                                                      ),
                                                      child: AnimatedContainer(
                                                        duration: const Duration(
                                                            milliseconds: 300),
                                                        height: 40.h,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                          horizontal: 15.w,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: idArea == beforeID
                                                              ? AppTheme
                                                                  .BASE_COLOR
                                                              : AppTheme
                                                                  .WHITE_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: AppTheme
                                                                  .BASE_COLOR),
                                                        ),
                                                        child: Center(
                                                          child: Mystyle().syleText(
                                                              value
                                                                  .areaModels!
                                                                  .area![index]
                                                                  .area!,
                                                              idArea == beforeID
                                                                  ? AppTheme
                                                                      .WHITE_COLOR
                                                                  : Colors.grey,
                                                              18.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Visibility(
                                                visible: selectIndex == index,
                                                child: Container(
                                                  height: 5.h,
                                                  width: 5.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme.BASE_COLOR,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              })),
                      SizedBox(
                        height: 5.h,
                      ),
                      NavBarStatusBooking(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: value.isloading
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: AppTheme.BASE_COLOR,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    const Text(
                                      "ກຳລັງໂຫຼດຂໍ້ມູນ...",
                                      style: TextStyle(
                                        fontFamily: 'Phetsarath-OT',
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : value.gettablelist == null
                                ? const Center(
                                    child: Text("ບໍ່ມີຂໍ້ມູນໂຕະ"),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        GridView.count(
                                          crossAxisCount: 2,
                                          physics: ScrollPhysics(),
                                          childAspectRatio: (0.8.w / .5.h),
                                          shrinkWrap: true,
                                          crossAxisSpacing: 20.0,
                                          mainAxisSpacing: 10.0,
                                          children: List.generate(
                                              value.gettablelist!.table!.length,
                                              (index) {
                                            return GestureDetector(
                                              onTap: (() async {
                                                setState(() {
                                                  selectIndex = index;
                                                });
                                                if (value.gettablelist!
                                                        .table![index].statusAv ==
                                                    1) {
                                                  Mystyle().dialogError(
                                                      context,
                                                      "ແຈ້ງເຕືອນ",
                                                      "ໂຕະກຳລັງດຳເນີນການຢູ່");
                                                } else {
                                                  setState(() {
                                                    selectTable = index;
                                                  });
                                                  CountPre().setTableId(value
                                                      .gettablelist!
                                                      .table![index]
                                                      .id!);
                                                  CountPre().setTableName(value
                                                      .gettablelist!
                                                      .table![index]
                                                      .name!);
                                                  CountPre().setArea(value
                                                      .gettablelist!
                                                      .table![index]
                                                      .tablearea!
                                                      .area!);

                                                  context
                                                      .read<ClickTableProvider>()
                                                      .clickTableProvider(true);
                                                }
                                              }),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 10.h,
                                                      width: 120.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color:
                                                              AppTheme.BASE_COLOR,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 50.h,
                                                          width: 10.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: checkStatus(
                                                              value
                                                                  .gettablelist!
                                                                  .table![index]
                                                                  .statusAv!,
                                                            ),
                                                            border: Border.all(
                                                                color: AppTheme
                                                                    .BASE_COLOR),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Container(
                                                            height: 70.h,
                                                            width: 130.w,
                                                            decoration: BoxDecoration(
                                                                color: selectTable == index
                                                                    ? AppTheme
                                                                        .BASE_COLOR
                                                                    : AppTheme
                                                                        .GREY_COLOR,
                                                                border: Border.all(
                                                                    color: AppTheme
                                                                        .BASE_COLOR),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Stack(
                                                              alignment: Alignment
                                                                  .topRight,
                                                              children: [
                                                                selectTable ==
                                                                        index
                                                                    ? Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: AppTheme
                                                                            .WHITE_COLOR,
                                                                      )
                                                                    : SizedBox(),
                                                                Center(
                                                                  child: Text(
                                                                    value
                                                                        .gettablelist!
                                                                        .table![
                                                                            index]
                                                                        .name!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: selectTable ==
                                                                              index
                                                                          ? AppTheme
                                                                              .WHITE_COLOR
                                                                          : AppTheme
                                                                              .BASE_COLOR,
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Container(
                                                          height: 50.h,
                                                          width: 10.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: AppTheme
                                                                    .BASE_COLOR),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Container(
                                                      height: 10.h,
                                                      width: 120.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppTheme
                                                                .BASE_COLOR),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                      )
                    ],
                  );
                }
              }),
            ),
          )),
    );
  }
}
