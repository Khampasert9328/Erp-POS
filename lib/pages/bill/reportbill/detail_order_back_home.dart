import 'package:badges/badges.dart' as Badges;
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';

import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DetailOrderBackHome extends StatefulWidget {
  GetOrder? data;
  int index;
  DetailOrderBackHome({super.key, required this.data, required this.index});
  @override
  State<DetailOrderBackHome> createState() => _DetailOrderBackHomeState();
}

class _DetailOrderBackHomeState extends State<DetailOrderBackHome> {
  @override
  Widget build(BuildContext context) {
    int? sum = 0;
    int total = 0;
    for (var i in widget.data!.product!) {
      int pricesal = int.parse(i.pricesale.toString());
      int? amount = i.amount;
      sum = pricesal * amount!;
      total += sum;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${widget.data!.billid}",
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
                      Badges.Badge(
                        badgeContent: Text(
                          "${widget.data}",
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
                            "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)}ກີບ",
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
                    String? billNo = await CountPre().getBillNo();
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

                      for (var i in widget.data!.product!) {
                        String size = setSize(i.size!);
                        await SunmiPrinter.printRow(cols: [
                          ColumnMaker(text: '${i.name}', width: 6),
                          ColumnMaker(
                              text:
                                  '${i.amount} $size ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(i.pricesale)}',
                              width: 6,
                              align: SunmiPrintAlign.RIGHT),
                        ]);
                      }
                      await SunmiPrinter.line();
                      await SunmiPrinter.printRow(cols: [
                        ColumnMaker(text: 'ລາຄາລວມ:', width: 6),
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
                    } catch (e) {
                      print("error:$e");
                    }
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
                  flex: 2,
                  child: Text(
                    "ຂະໜາດ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
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
            for (var i in widget.data!.product!)
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${widget.index += 1}",
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
                      child: Text(
                        "${setSize(i.size!)}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${i.amount}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
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
              ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
