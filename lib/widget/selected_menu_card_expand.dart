// ignore_for_file: use_build_context_synchronously

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/category/category_models.dart';
import 'package:erp_pos/model/food_menu_model.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/provider/bill/print_bill_provider.dart';
import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/utils/sqliteERP/sqlite_erp_pos.dart';
import 'package:erp_pos/widget/add_amount.dart';
import 'package:erp_pos/widget/calculate_money.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/theme.dart';

class SelectedMenuCardExpand extends StatefulWidget {
  VoidCallback onNext;

  bool selectMenu = false;

  SelectedMenuCardExpand({required this.onNext, required this.selectMenu});

  @override
  State<SelectedMenuCardExpand> createState() => _SelectedMenuCardExpandState();
}

class _SelectedMenuCardExpandState extends State<SelectedMenuCardExpand> {
  // int count = 0;
  // void setNumber(bool isAdd) {
  //   if (isAdd) {
  //     setState(() {
  //       count++;
  //     });
  //   } else {
  //     if (count > 0) {
  //       setState(() {
  //         count--;
  //       });
  //     }
  //   }
  // }

  bool? clicktable = false;
  int? getCount;

  @override
  void initState() {
    CountPre().getClickTable().then((value) async {
      clicktable = await CountPre().getClickTable();
    });
    CountPre().getCount().then((value) async {
      getCount = await CountPre().getCount();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              clicktable == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ລາຍການອໍເດີ",
                          style: TextStyle(
                              fontFamily: 'Phetsarath-OT',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.BASE_COLOR),
                        ),
                        Text(
                          "ໂຕະ",
                          style: TextStyle(
                              fontFamily: 'Phetsarath-OT',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.BASE_COLOR),
                        ),
                      ],
                    )
                  : SizedBox(),
              Expanded(
                child: Consumer<GetFoodMenuProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                        itemCount: value.getFoodMenuModel.length,
                        itemBuilder: ((context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                height: 85.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(7.r)),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      height: 63.h,
                                      width: 69.w,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: imageProvider)),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.image_outlined,
                                              size: 70,
                                              color: AppTheme.GREY_COLOR),
                                      imageUrl: value.getFoodMenuModel[index]
                                          .data.thumbnails!.first.uri!,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: AppTheme.BASE_COLOR,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.getFoodMenuModel[index].data
                                                .name!,
                                            style: TextStyle(
                                                fontFamily: 'Phetsarath-OT',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppTheme.BASE_COLOR),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                                text: 'ລາຄາ ',
                                                style: TextStyle(
                                                    fontFamily: 'Phetsarath-OT',
                                                    fontSize: 14.sp,
                                                    color: AppTheme.BASE_COLOR),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.getFoodMenuModel[index].totalAmount)} ກີບ',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Phetsarath-OT',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                          ),
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                const Text("ຈຳນວນ"),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Container(
                                                  height: 30.h,
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme.WHITE_COLOR,
                                                    border: Border.all(
                                                      color:
                                                          AppTheme.BASE_COLOR,
                                                    ),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "+",
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                    ),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Consumer<FoodMenuProvider>(
                                                  builder: (context, value,
                                                          child) =>
                                                      Text("${value.counter}"),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Container(
                                                  height: 30.h,
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme.WHITE_COLOR,
                                                    border: Border.all(
                                                      color:
                                                          AppTheme.BASE_COLOR,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //////////////////////ປຸ່ມລົບຂໍ້ມູນ

                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              print("count:$getCount");
                                              context
                                                  .read<GetFoodMenuProvider>()
                                                  .deleteTotalAmount(value
                                                      .getFoodMenuModel[index]
                                                      .totalAmount);
                                              context
                                                  .read<GetFoodMenuProvider>()
                                                  .deleteData(index);
                                            },
                                            icon: Image.asset(
                                              ERPImages.icondelete,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 28.h,
                                width: 28.w,
                                child: Badge(
                                  badgeContent: Center(
                                    child: Text(
                                      "S",
                                      style: TextStyle(
                                          color: AppTheme.WHITE_COLOR,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  badgeColor: AppTheme.GREEN_COLOR,
                                ),
                              ),
                            ],
                          );
                        }));
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                decoration: const BoxDecoration(color: Color(0xFFF4F5F6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shopping_cart,
                              size: (30.w + 30.h) / 2,
                            )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          'ລວມລາຄາ: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ',
                          style: TextStyle(
                            fontFamily: 'Phetsarath-OT',
                            fontSize: 15.sp,
                            color: AppTheme.BASE_COLOR,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'ກີບ',
                      style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp),
                    )
                  ],
                ),
              ),
              clicktable == true
                  ? sendingtokitchen()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        context
                                .read<GetFoodMenuProvider>()
                                .getFoodMenuModel
                                .isEmpty
                            ? const SizedBox()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    primary: AppTheme.BASE_COLOR),
                                onPressed: widget.onNext,
                                child: Text(
                                  'ຕໍ່ໄປ',
                                  style: TextStyle(
                                    fontFamily: 'Phetsarath-OT',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                        SizedBox(
                          width: 20.w,
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  sendingtokitchen() => Padding(
        padding: const EdgeInsets.only(right: 18, left: 18, bottom: 8),
        child: SizedBox(
          height: 39.h,
          width: double.infinity,
          child: context.read<GetFoodMenuProvider>().getFoodMenuModel.isEmpty
              ? const Text("")
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      primary: AppTheme.BASE_COLOR),
                  onPressed: () async {
                    SharedPreferences pre =
                        await SharedPreferences.getInstance();
                    await pre.remove(CountPre().clicktable);

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
                              ColumnMaker(text: '${data.data.name}', width: 6),
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
                  child: Text(
                    'ສົ່ງຫ້ອງຄົວ',
                    style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
        ),
      );
}