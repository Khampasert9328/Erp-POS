// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously

import 'package:badges/badges.dart' as Badges;
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/model/gettableall/gettable_all_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/deleteorder/delete_order_all_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/bottombar_of_bill.dart';
import 'package:erp_pos/widget/paymentmethod.dart';
import 'package:erp_pos/widget/paymentmethod_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BodyDetailBill extends StatefulWidget {
  // List<Product> data;
  String date;
  String tablename;
  String billid;
  String orderid;
  String tableid;
  int status;

  BodyDetailBill(
      {super.key,
      required this.tableid,
      // required this.data,
      required this.date,
      required this.tablename,
      required this.status,
      required this.billid,
      required this.orderid});

  @override
  State<BodyDetailBill> createState() => _BodyDetailBillState();
}

class _BodyDetailBillState extends State<BodyDetailBill> {
  @override
  Widget build(BuildContext context) {
    bool checkcancel = context.read<SetData>().checkcancelorder;
    int sum = 0;
    int total = 0;

    for (var data in context
        .read<GetOrderByIssueDateProvider>()
        .order!
        .order!
        .first
        .product!) {
      int amount = data.amount!;
      int price = int.parse(data.pricesale.toString());
      sum = amount * price;
      total += sum;
    }

    var endD = "${widget.date}";
    var senD = endD.split(" ");
    var showdate = senD[0].trim();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          "ເລກໂຕະ ${widget.tablename}",
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
                          "",
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
                              fontFamily: 'Phetsarath-OT',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.status == 0
                        ? GestureDetector(
                            onTap: () async {
                              context
                                  .read<SetData>()
                                  .setCheckOrderToBlackhome(false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PayMentMethod(
                                            tatal: total,
                                            tablename: widget.tablename,
                                          )));
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
                                  Center(
                                    child: Text(
                                      "ຄິດໄລ່ເງິນ",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: AppTheme.BASE_COLOR,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Phetsarath-OT',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
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
                                text: '',
                                width: 6,
                                align: SunmiPrintAlign.RIGHT),
                          ]);

                          await SunmiPrinter.line();
                          await SunmiPrinter.printText('ລາຍການອາຫານ',
                              style: SunmiStyle(
                                  align: SunmiPrintAlign.CENTER,
                                  bold: true,
                                  fontSize: SunmiFontSize.MD));
                          for (var i in context
                              .read<GetOrderByIssueDateProvider>()
                              .order!
                              .order!
                              .first
                              .product!) {
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
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: ((context, setState) {
                                return AlertDialog(
                                  content: Text(
                                    "ກາລຸນາເຊື່ອມຕໍ່ປິ່ນເຕີ",
                                    style: TextStyle(
                                      fontFamily: 'Phetsarath-OT',
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  actions: [
                                    Container(
                                      height: 40.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          color: AppTheme.BASE_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "ຕົກລົງ",
                                          style: TextStyle(
                                              fontFamily: 'Phetsarath-OT',
                                              fontSize: 16.sp,
                                              color: AppTheme.WHITE_COLOR),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          );
                        }
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
                                  fontFamily: 'Phetsarath-OT',
                                ),
                              ),
                            ),
                          ],
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    fontFamily: 'Phetsarath-OT',
                  ),
                ),
                Text(
                  "ວັນທີ: $showdate",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                checkcancel
                    ? SizedBox()
                    : GestureDetector(
                        onTap: (() async {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: ((context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  "ຕ້ອງການຍົກເລີກອໍເດີໂຕະນີ້ແທ້ບໍ?",
                                  style: TextStyle(
                                    fontFamily: 'Phetsarath-OT',
                                    fontSize: 18.sp,
                                  ),
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "ບໍ່, ຕ້ອງການ",
                                      style: TextStyle(
                                        fontFamily: 'Phetsarath-OT',
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  CupertinoDialogAction(
                                    child: Text(
                                      "ຕ້ອງການ",
                                      style: TextStyle(
                                        fontFamily: 'Phetsarath-OT',
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await context
                                          .read<DeleteOrderAllProvider>()
                                          .deleteOrderAllProvider(context,
                                              widget.billid, widget.orderid);

                                      String idarea =
                                          context.read<AreaProvider>().idarea;
                                      // ignore: use_build_context_synchronously
                                      await context
                                          .read<AreaProvider>()
                                          .callTable(context, idarea);

                                      // ignore: use_build_context_synchronously
                                      await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage()),
                                          (route) => false);
                                    },
                                  ),
                                ],
                              );
                            }),
                          );
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                              color: AppTheme.BASE_COLOR,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "ຍົກເລີກອໍເດີທັງໝົດ",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 15.sp,
                                color: AppTheme.WHITE_COLOR),
                          ),
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
                      fontFamily: 'Phetsarath-OT',
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
                      fontFamily: 'Phetsarath-OT',
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
                      fontFamily: 'Phetsarath-OT',
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
                  flex: 2,
                  child: Text(
                    "ລາຄາ",
                    style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(""),
                )
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: context
                      .read<GetOrderByIssueDateProvider>()
                      .order!
                      .order!
                      .first
                      .product!
                      .length,
                  itemBuilder: ((context, index) {
                    String size = setSize(context
                        .read<GetOrderByIssueDateProvider>()
                        .order!
                        .order!
                        .first
                        .product![index]
                        .size!);
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "${context.read<GetOrderByIssueDateProvider>().order!.order!.first.product![index].name}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Phetsarath-OT',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "$size",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Phetsarath-OT',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${context.read<GetOrderByIssueDateProvider>().order!.order!.first.product![index].amount}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Phetsarath-OT',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetOrderByIssueDateProvider>().order!.order!.first.product![index].pricesale)}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (() {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: ((context) {
                                        return CupertinoAlertDialog(
                                          title: Text(
                                            "ຕ້ອງການລົບອາຫານນີ້ແທ້ບໍ?",
                                            style: TextStyle(
                                              fontFamily: 'Phetsarath-OT',
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text(
                                                "ບໍ່, ຕ້ອງການ",
                                                style: TextStyle(
                                                  fontFamily: 'Phetsarath-OT',
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            CupertinoDialogAction(
                                              child: Text(
                                                "ຕ້ອງການ",
                                                style: TextStyle(
                                                  fontFamily: 'Phetsarath-OT',
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                              onPressed: () async {
                                                // widget.data.removeAt(index);
                                                // setState(() {});

                                                // Navigator.pop(context);

                                                await Future.wait([
                                                  DeleteOrderAllProvider()
                                                      .deleteOrderManyProvider(
                                                    widget.orderid,
                                                    widget.billid,
                                                    context
                                                        .read<
                                                            GetOrderByIssueDateProvider>()
                                                        .order!
                                                        .order!
                                                        .first
                                                        .product![index]
                                                        .productid!,
                                                    context
                                                        .read<
                                                            GetOrderByIssueDateProvider>()
                                                        .order!
                                                        .order!
                                                        .first
                                                        .product![index]
                                                        .size!,
                                                  ),
                                                  DeleteOrderAllProvider()
                                                      .updateOrderProvider(
                                                    context,
                                                    widget.tableid,
                                                    widget.billid,
                                                    widget.orderid,
                                                    index,
                                                    context
                                                        .read<
                                                            GetOrderByIssueDateProvider>()
                                                        .order!
                                                        .order!
                                                        .first
                                                        .product![index]
                                                        .productid!,
                                                    context
                                                        .read<
                                                            GetOrderByIssueDateProvider>()
                                                        .order!
                                                        .order!
                                                        .first
                                                        .product![index]
                                                        .size!,
                                                  )
                                                ]);
                                                setState(() {
                                                  context
                                                      .read<
                                                          GetOrderByIssueDateProvider>()
                                                      .deleteOrder(index);
                                                  Navigator.pop(context);
                                                });
                                                // Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                    );
                                  }),
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    size: 30.sp,
                                    color: AppTheme.RED_COLOR,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
