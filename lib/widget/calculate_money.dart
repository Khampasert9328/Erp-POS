// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:badges/badges.dart';
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/provider/bill/print_bill_customers_provider.dart';
import 'package:erp_pos/provider/bill/print_bill_provider.dart';
import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateMoney extends StatelessWidget {
  final tablename;
  const CalculateMoney({
    Key? key,
    required this.tablename,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetFoodMenuProvider>(builder: ((context, value, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppTheme.WHITE_COLOR,
            elevation: 0,
            title: Text(
              tablename ?? 'ບໍ່ມີໂຕະ',
              style: TextStyle(
                  color: AppTheme.BASE_COLOR, fontWeight: FontWeight.bold),
            ),
          ),
          bottomNavigationBar: Container(
            height: 145.h,
            child: BottomAppBar(
              notchMargin: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Badge(
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
                            child: Image.asset(
                              ERPImages.cart,
                              height: 45.h,
                              width: 45.w,
                              color: AppTheme.GREY_COLOR,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "ລາຄາລວມ:",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppTheme.BASE_COLOR,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Row(
                            children: [
                              Text(
                                "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppTheme.RED_COLOR,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences pre =
                                await SharedPreferences.getInstance();
                            String? getidtable =
                                pre.getString(CountPre().tablename);

                            CheckExpiredPackage()
                                .getCheckExpiredPackage(context)
                                .then((value) async {
                              PrintBillCustomers().getbillCustomers(context);

                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String? getzone =
                                  preferences.getString(CountPre().idzone);
                              SharedPreferences pri =
                                  await SharedPreferences.getInstance();
                              String? billNo = pri.getString(CountPre().billNo);

                              try {
                                await SunmiPrinter.startTransactionPrint();
                                await SunmiPrinter.printText('ໃບຈ່າຍເງິນ',
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
                                          '${DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now())}',
                                      width: 6,
                                      align: SunmiPrintAlign.RIGHT),
                                ]);
                                await SunmiPrinter.printRow(cols: [
                                  ColumnMaker(
                                      text: 'ໂຊນ ຫຼື ພື້ນທີ່', width: 6),
                                  ColumnMaker(
                                      text: '${getzone??"none"}',
                                      width: 6,
                                      align: SunmiPrintAlign.RIGHT),
                                ]);
                                await SunmiPrinter.printRow(cols: [
                                  ColumnMaker(text: 'ເລກໂຕະ', width: 6),
                                  ColumnMaker(
                                      text: '${getidtable??"none"}',
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
                                  /////////////////////////
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
                                await SunmiPrinter.printRow(cols: [
                                  ColumnMaker(text: 'ລາຄາລວມ:', width: 6),
                                  ColumnMaker(
                                      text:
                                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ',
                                      width: 6,
                                      align: SunmiPrintAlign.RIGHT),
                                ]);

                                await SunmiPrinter.line();
                                await SunmiPrinter.printText('ຂໍຂອບໃຈ',
                                    style: SunmiStyle(
                                        align: SunmiPrintAlign.CENTER,
                                        bold: true,
                                        fontSize: SunmiFontSize.MD));
                                await SunmiPrinter.lineWrap(3);
                                await SunmiPrinter.submitTransactionPrint();
                                await SunmiPrinter.exitTransactionPrint();

                                context.read<GetFoodMenuProvider>().clearKitchenData();
                              } catch (e) {
                                throw Exception("ບໍ່ມີປິ່ນເຕີ");
                              }
                            });
                 
                          },
                          child: Container(
                            height: 60.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppTheme.BASE_COLOR,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ERPImages.printbill),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Center(
                                  child: Text(
                                    "ພິມໃບບິນ",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppTheme.BASE_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.BASE_COLOR,
                              border: Border.all(
                                color: AppTheme.BASE_COLOR,
                              )),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PayMentMethod(
                                      tablename: tablename,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "ຄິດໄລ່ເງິນ",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppTheme.WHITE_COLOR,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => FoodMenu()));
                      },
                      child: Container(
                        height: 35.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.BASE_COLOR),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Image.asset(
                              ERPImages.addcart,
                              height: 22.h,
                              width: 22.w,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "ສັ່ງຕື່ມ",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ລາຍການອໍເດີ",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Divider(),
                Container(
                  decoration: BoxDecoration(color: AppTheme.BASE_COLOR),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "ລ/ດ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ລາຍການ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "ຂະໜາດ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "ຈ/ນ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "ລາຄາ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Expanded(child: Consumer<GetFoodMenuProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                        itemCount: value.getFoodMenuModel.length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("${index + 1}"),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                    "${value.getFoodMenuModel[index].data.name}"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(child: Text("0")),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                      "${value.getFoodMenuModel[index].number}"),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.getFoodMenuModel[index].totalAmount)}"),
                              ),
                            ],
                          );
                        }));
                  },
                )),
                Divider(),
              ],
            ),
          ));
    }));
  }
}
