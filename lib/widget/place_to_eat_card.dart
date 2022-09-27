// ignore_for_file: unused_import, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously
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
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/calculate_money.dart';
import 'package:erp_pos/widget/order_to_take_home.dart';
import 'package:erp_pos/widget/selected_menu_card.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceToEatCard extends StatefulWidget {
  ScrollController scrollController;

  PlaceToEatCard({required this.scrollController});

  @override
  State<PlaceToEatCard> createState() => _PlaceToEatCardState();
}

class _PlaceToEatCardState extends State<PlaceToEatCard> {
  bool selectindex = true;
  bool selecbutton = true;
  int? selectTable;
  FoodMenuModel? model;

  int? isselect;
  String? idtable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selecbutton = true;
                });
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: selecbutton == true
                        ? AppTheme.BASE_COLOR
                        : AppTheme.WHITE_COLOR,
                    border: Border.all(color: AppTheme.BASE_COLOR),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Text(
                      "ກັບຄືນ",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: selecbutton == true
                              ? AppTheme.WHITE_COLOR
                              : AppTheme.BASE_COLOR),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {

                SharedPreferences pre = await SharedPreferences.getInstance();
                String? getidtable = pre.getString(CountPre().tablename);
            

                CheckExpiredPackage()
                    .getCheckExpiredPackage(context)
                    .then((value) async {
            //       PrintBillKitchenProvider().getprint();

            //     SharedPreferences preferences =
            //         await SharedPreferences.getInstance();
            //     String? getzone = preferences.getString(CountPre().idzone);
            //     SharedPreferences pri = await SharedPreferences.getInstance();
            //     String? billNo = pri.getString(CountPre().billNo);

            //     print("billNO:$billNo");

            //     try {
                  
            //     await SunmiPrinter.startTransactionPrint();
            //     await SunmiPrinter.printText('ໃບບິນຫ້ອງຄົວ',
            //         style: SunmiStyle(
            //             align: SunmiPrintAlign.CENTER,
            //             bold: true,
            //             fontSize: SunmiFontSize.LG));
            //     await SunmiPrinter.line();

            //     await SunmiPrinter.printRow(cols: [
            //       ColumnMaker(text: 'ໃບບິນເລກທີ', width: 6),
            //       ColumnMaker(
            //           text: '$billNo',
            //           width: 6,
            //           align: SunmiPrintAlign.RIGHT),
            //     ]);

            //     await SunmiPrinter.printRow(cols: [
            //       ColumnMaker(text: 'ວັນເວລາ', width: 6),
            //       ColumnMaker(
            //           text: '${DateFormat("yyy-MM-dd HH:mm").format(DateTime.now())}',
            //           width: 6,
            //           align: SunmiPrintAlign.RIGHT),
                      
            //     ]);
            //     await SunmiPrinter.printRow(cols: [
            //       ColumnMaker(text: 'ໂຊນ ຫຼື ພື້ນທີ່', width: 6),
            //       ColumnMaker(
            //           text: '$getzone',
            //           width: 6,
            //           align: SunmiPrintAlign.RIGHT),
                      
            //     ]);
            //     await SunmiPrinter.printRow(cols: [
            //       ColumnMaker(text: 'ເລກໂຕະ', width: 6),
            //       ColumnMaker(
            //           text: '$getidtable',
            //           width: 6,
            //           align: SunmiPrintAlign.RIGHT),
                      
            //     ]);


            //     await SunmiPrinter.line();
            //     await SunmiPrinter.printText('ລາຍການອາຫານ',
            //         style: SunmiStyle(
            //             align: SunmiPrintAlign.CENTER,
            //             bold: true,
            //             fontSize: SunmiFontSize.MD));

            //       for (var data in context.read<GetFoodMenuProvider>().getFoodMenuModel) {

            //         await SunmiPrinter.printRow(cols: [
            //       ColumnMaker(text: '${data.data.name}', width: 6),
            //       ColumnMaker(
            //           text: '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(data.number)} x ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(data.totalAmount)}',
            //           width: 6,
            //           align: SunmiPrintAlign.RIGHT),
            //     ]);
                    
            //       }
            //     await SunmiPrinter.line();
                

            //     await SunmiPrinter.printText('ຂໍຂອບໃຈ',
            //         style: SunmiStyle(
            //             align: SunmiPrintAlign.CENTER,
            //             bold: true,
            //             fontSize: SunmiFontSize.MD));
            //     await SunmiPrinter.lineWrap(3);
            //     await SunmiPrinter.submitTransactionPrint();
            //     await SunmiPrinter.exitTransactionPrint();
            //     } catch (e) {

            //       print("error:$e");
                  
            //     }
              });
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        insetAnimationDuration: Duration(milliseconds: 5),
                        insetAnimationCurve: Curves.bounceOut,
                        child: Container(
                          height: 150.h,
                          width: 100.w,
                          child: Column(
                            children: [
                              Image.asset(
                                ERPImages.animation,
                                height: 77.h,
                                width: 77.w,
                              ),
                              Text(
                                "ອໍເດີໄດ້ສົ່ງໄປຫ້ອງຄົວແລ້ວ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
               await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CalculateMoney(
                      tablename: getidtable,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: selecbutton == false
                      ? AppTheme.BASE_COLOR
                      : AppTheme.WHITE_COLOR,
                  border: Border.all(color: AppTheme.BASE_COLOR),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      "ສົ່ງຫ້ອງຄົວ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: selecbutton == false
                            ? AppTheme.WHITE_COLOR
                            : AppTheme.BASE_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectindex = true;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: selectindex == true
                              ? AppTheme.BASE_COLOR
                              : AppTheme.WHITE_COLOR,
                          border: Border.all(color: AppTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            "ກິນຢູ່ຮ້ານ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: selectindex == true
                                    ? AppTheme.WHITE_COLOR
                                    : AppTheme.BASE_COLOR),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectindex = false;
                      });
                      Mystyle().showAlertloadingsuccess(
                          context, "ແຈ້ງເຕືອນ", "ກຳລັງພັດທະນາ");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: selectindex == false
                              ? AppTheme.BASE_COLOR
                              : AppTheme.WHITE_COLOR,
                          border: Border.all(color: AppTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            "ສັ່ງກັບບ້ານ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: selectindex == false
                                    ? AppTheme.WHITE_COLOR
                                    : AppTheme.BASE_COLOR),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            if (selectindex == true)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "ເລືອກໂຕະ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.GREY_COLOR,
                            border: Border.all(color: AppTheme.WHITE_COLOR),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'ຄົ້ນຫາໂຕະ',
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.search,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: FutureBuilder<List<Area>>(
                            future: AreaProvider().getZone(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Consumer<AreaProvider>(
                                  builder: ((context, model, _) {
                                    return ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          String? id =
                                              snapshot.data![index].id ?? "";
                      
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        setState(() {
                                                          isselect = index;
                                                          idtable = id;
                                                        });
                                                        SharedPreferences
                                                            preferences =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        preferences.setString(
                                                            CountPre().idzone,
                                                            snapshot.data![index]
                                                                .area!);
                                                        preferences.setString(
                                                            CountPre().tableid,
                                                            idtable.toString());
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 8,
                                                            ),
                                                            child: Container(
                                                              height: 40.h,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 15.w,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: isselect == index
                                                                      ? AppTheme
                                                                          .BASE_COLOR
                                                                      : AppTheme
                                                                          .WHITE_COLOR,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border.all(
                                                                      color: AppTheme
                                                                          .BASE_COLOR)),
                                                              child: Center(
                                                                child: Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .area!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18.sp,
                                                                    color: isselect == index
                                                                        ? AppTheme
                                                                            .WHITE_COLOR
                                                                        : AppTheme
                                                                            .GREY_COLOR,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  NavBarStatusBooking(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    // height: 300.h,
                    child: FutureBuilder<List<GetTable>>(
                      future: GetTableProvider().gettablebyid(context, idtable),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Consumer<GetTableProvider>(
                            builder: ((context, model, _) {
                              return SingleChildScrollView(
                                  child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: (0.7 / .4),
                                shrinkWrap: true,
                                children: List.generate(snapshot.data!.length,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setString(
                                            CountPre().tableid,
                                            snapshot.data![index].id!);
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        preferences.setString(
                                            CountPre().tablename,
                                            snapshot.data![index].name!);
                                      },
                                      child: Container(
                                        height: 50.h,
                                        color: AppTheme.GREY_COLOR,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: AppTheme.GREEN_COLOR,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data![index].name!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ));
                            }),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.BASE_COLOR,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (!selectindex) OrderToTakeHome()
          ],
        ),
      ),
    );
  }
}
