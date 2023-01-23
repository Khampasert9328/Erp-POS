// ignore_for_file: unnecessary_string_interpolations

import 'package:badges/badges.dart';
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/model/gettableall/gettable_all_models.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/bottombar_of_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BodyDetailBill extends StatefulWidget {
  List<Product> data;
  
  BodyDetailBill({
    super.key,
    required this.data,
   
  });

  @override
  State<BodyDetailBill> createState() => _BodyDetailBillState();
}

class _BodyDetailBillState extends State<BodyDetailBill> {
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    int total = 0;

    for (var data in widget.data) {
      int amount = data.amount!;
      int price = int.parse(data.pricesale.toString());
      sum = amount * price;
      total += sum;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ເລກໂຕະ",
          style: TextStyle(
            color: AppTheme.BASE_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
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
                          "${widget.data.length}",
                          style: TextStyle(
                            color: AppTheme.WHITE_COLOR,
                          ),
                        ),
                        child: Image.asset(
                          ERPImages.cart,
                          height: 45.h,
                          width: 45.w,
                          color: AppTheme.BASE_COLOR,
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
                            "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ກີບ",
                            style: TextStyle(
                              fontFamily: 'Phetsarath-OT',
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
                GestureDetector(
                  onTap: () async {
                    try {
                      await SunmiPrinter.startTransactionPrint();
                      await SunmiPrinter.printText('ໃບບິນ',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: SunmiFontSize.LG));
                      await SunmiPrinter.line();

                      await SunmiPrinter.printRow(cols: [
                        ColumnMaker(text: 'ໃບບິນເລກທີ', width: 6),
                        ColumnMaker(
                            text: 'none',
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
                        ColumnMaker(text: 'ເລກໂຕະ', width: 6),
                        ColumnMaker(
                            text: '', width: 6, align: SunmiPrintAlign.RIGHT),
                      ]);

                      await SunmiPrinter.line();
                      await SunmiPrinter.printText('ລາຍການອາຫານ',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: SunmiFontSize.MD));
                      for (var i in widget.data) {
                        String size = setSize(i.size!);
                        await SunmiPrinter.printRow(cols: [
                          ColumnMaker(text: '${i.name}', width: 6),
                          ColumnMaker(
                              text:
                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(i.amount)} $size ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(i.pricesale)}',
                              width: 6,
                              align: SunmiPrintAlign.RIGHT),
                        ]);
                      }
                      await SunmiPrinter.line();
                      await SunmiPrinter.line();
                      await SunmiPrinter.printRow(cols: [
                        ColumnMaker(text: 'ລາຄາລວມ', width: 6),
                        ColumnMaker(
                            text:
                                '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)}',
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
                    } catch (e) {}
                  },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
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
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ພະນັກງານຮັບອໍເດີ:",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ລາຍການອໍເດີ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Text("# Order ${widget.dataorder!.prefix}"),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "ລ/ດ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "ລາຍການ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "ຂະໜາດ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "ຈຳນວນ",
                    style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "ລາຄາ",
                    style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            for (var i in widget.data)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${widget.data.length}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "${i.name}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "${setSize(i.size!)}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${i.amount}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(i.pricesale)}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
