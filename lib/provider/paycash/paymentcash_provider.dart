// ignore_for_file: use_build_context_synchronously

import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/paymentcash/paymentcash_service.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';

import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class PaymentCashProvider extends ChangeNotifier {
  CreatePaymentCashModels? _createPaymentCashModels;
  CreatePaymentCashModels? get createPaymentCashModels =>
      _createPaymentCashModels;
  bool isload = false;
  bool get isloading => isload;

  Future<void> createpaymentcashprovider(
    BuildContext context,
    int number,
  ) async {
    String? moneyRecive = await CountPre().getmoneyReceived();
    int replaceString = int.parse(moneyRecive!);
    int? moneychange = await CountPre().getmoneyChange();
    String? billid = await CountPre().getBillIdDetail();
    String? billidtobackhome = await CountPre().getBillIdTobackHome();
    String? sessionid = await CountPre().getSessionId();
    int paymenttype = 0;
    bool checkordertoblackhome = context.read<SetData>().checkordertoblackhome;
    bool checkorderbill = context.read<SetData>().checkorderbill;
    //////////////////////////////////////////////////////
    String? startDate = await CountPre().getDateSupscribe();
    var std = "$startDate";
    var stdS = std.split(' ');
    var stdSS = stdS[0].trim();
    var rStd = stdSS.replaceAll("-", "");
    /////////////////////////////////////////////
    String? endDate = await CountPre().getDateExpired();
    var ed = '$endDate';
    var edX = ed.split(' ');
    var edXX = edX[0].trim();
    var redX = edXX.replaceAll("-", "");

    try {
      isload = true;
      checkordertoblackhome
          ? _createPaymentCashModels = await createpaymentcash(
              billidtobackhome!, number, sessionid!, rStd, redX, paymenttype)
          : _createPaymentCashModels = await createpaymentcash(
              billid!, number, sessionid!, rStd, redX, paymenttype);

      if (_createPaymentCashModels != null) {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                insetAnimationDuration: const Duration(milliseconds: 5),
                insetAnimationCurve: Curves.bounceOut,
                child: SizedBox(
                  height: 210.h,
                  width: 100.w,
                  child: Center(
                      child: Column(
                    children: [
                      Image.asset(
                        ERPImages.success,
                        height: 104.h,
                        width: 104.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "ຊຳລະເງິນສຳເລັດແລ້ວ",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppTheme.BASE_COLOR,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 40.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: AppTheme.GREY_COLOR,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppTheme.BASE_COLOR),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                try {
                                  String? tableid1 =
                                      await CountPre().getTableId();
                                  String? tablename1 =
                                      await CountPre().getTableName();
                                  String? areaid1 =
                                      await CountPre().getAreaId();
                                  String? areaname1 =
                                      await CountPre().getArea();
                                  await context
                                      .read<UpdateTableProvider>()
                                      .updateTableProvider(context, tableid1,
                                          tablename1, areaid1, areaname1);
                                  String idarea =
                                      context.read<AreaProvider>().idarea;
                                  await context
                                      .read<AreaProvider>()
                                      .callTable(context, idarea);

                                  await Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomePage()),
                                      (route) => false);
                                } catch (e) {
                                  rethrow;
                                }

                                // GetOrderTableModels? models = context
                                //     .read<GetOrderTableProvider>()
                                //     .orderTableModels;

                                // String idarea =
                                //     context.read<AreaProvider>().idarea;
                                // await context
                                //     .read<AreaProvider>()
                                //     .callTable(context, idarea);
                              },
                              child: Text(
                                "ປິດໜ້ານີ້",
                                style: TextStyle(
                                    color: AppTheme.BASE_COLOR,
                                    fontFamily: 'Phetsarath-OT'),
                              ),
                            ),
                          ),
                          Container(
                            height: 40.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: AppTheme.BASE_COLOR,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppTheme.WHITE_COLOR),
                            ),
                            child: TextButton(
                              onPressed: checkordertoblackhome
                                  ? () async {
                                      String? billNo =
                                          await CountPre().getBillNo();
                                      int total = 0;

                                      try {
                                        await SunmiPrinter
                                            .startTransactionPrint();
                                        await SunmiPrinter.printText('ໃບບິນ',
                                            style: SunmiStyle(
                                                align: SunmiPrintAlign.CENTER,
                                                bold: true,
                                                fontSize: SunmiFontSize.LG));
                                        await SunmiPrinter.line();

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ໃບບິນເລກທີ', width: 6),
                                          ColumnMaker(
                                              text: '$billNo',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ວັນເວລາ', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())}',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(text: 'ຊັ້ນ', width: 6),
                                          ColumnMaker(
                                              text: 'ກັບບ້ານ',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(text: 'ເລກໂຕະ', width: 6),
                                          ColumnMaker(
                                              text: 'ກັບບ້ານ',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.line();
                                        await SunmiPrinter.printText(
                                            'ລາຍການອາຫານ',
                                            style: SunmiStyle(
                                                align: SunmiPrintAlign.CENTER,
                                                bold: true,
                                                fontSize: SunmiFontSize.MD));

                                        for (var j in context
                                            .read<GetFoodMenuProvider>()
                                            .getFoodMenuModel) {
                                          String size = setSize(j.size);
                                          int sum = 0;

                                          int amount = j.amount;
                                          int pricesale = int.parse(
                                              j.specialprice.toString());
                                          sum = pricesale * amount;
                                          total += sum;

                                          await SunmiPrinter.printRow(cols: [
                                            ColumnMaker(
                                                text: '${j.data.name}',
                                                width: 6),
                                            ColumnMaker(
                                                text:
                                                    '${j.amount} $size ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(j.specialprice)}',
                                                width: 6,
                                                align: SunmiPrintAlign.RIGHT),
                                          ]);
                                        }

                                        await SunmiPrinter.line();
                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ລາຄາລວມ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ເງິນທີ່ໄດ້ຮັບ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(replaceString)}',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);
                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ເງິນທອນ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(moneychange)} ',
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
                                        await SunmiPrinter
                                            .submitTransactionPrint();
                                        await SunmiPrinter
                                            .exitTransactionPrint();
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
                                                width:  60.w,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.BASE_COLOR,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ຕົກລົງ",
                                              style: TextStyle(
                                                fontFamily: 'Phetsarath-OT',
                                                fontSize: 16.sp,
                                                color: AppTheme.WHITE_COLOR
                                              ),),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    );
                                      }
                                      await Future.delayed(
                                          Duration(seconds: 2));

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage()),
                                          (route) => false);
                                    }
                                  :checkorderbill?() async {
                                      String? areaname1 =
                                          await CountPre().getArea();
                                      String? tablename1 =
                                          await CountPre().getTableName();
                                      String? tableid1 =
                                          await CountPre().getTableId();

                                      String? areaid1 =
                                          await CountPre().getAreaId();
                                      String? billNo =
                                          await CountPre().getBillNo();
                                      int total = 0;

                                      try {
                                        await SunmiPrinter
                                            .startTransactionPrint();
                                        await SunmiPrinter.printText('ໃບບິນ',
                                            style: SunmiStyle(
                                                align: SunmiPrintAlign.CENTER,
                                                bold: true,
                                                fontSize: SunmiFontSize.LG));
                                        await SunmiPrinter.line();

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ໃບບິນເລກທີ', width: 6),
                                          ColumnMaker(
                                              text: '$billNo',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ວັນເວລາ', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())}',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(text: 'ຊັ້ນ', width: 6),
                                          ColumnMaker(
                                              text: '$areaname1',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(text: 'ເລກໂຕະ', width: 6),
                                          ColumnMaker(
                                              text: '$tablename1',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.line();
                                        await SunmiPrinter.printText(
                                            'ລາຍການອາຫານ',
                                            style: SunmiStyle(
                                                align: SunmiPrintAlign.CENTER,
                                                bold: true,
                                                fontSize: SunmiFontSize.MD));

                                        for (var j in context
                                            .read<GetOrderByIssueDateProvider>()
                                            .order!.order!.first.product!) {
                                     
                                            String size = setSize(j.size!);
                                            int sum = 0;

                                            int amount = j.amount!;
                                            int pricesale = int.parse(
                                                j.pricesale.toString());
                                            sum = pricesale * amount;
                                            total += sum;

                                            await SunmiPrinter.printRow(cols: [
                                              ColumnMaker(
                                                  text: '${j.name}', width: 6),
                                              ColumnMaker(
                                                  text:
                                                      '${j.amount} $size ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(j.pricesale)}',
                                                  width: 6,
                                                  align: SunmiPrintAlign.RIGHT),
                                            ]);
                                          
                                        }

                                        await SunmiPrinter.line();
                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ລາຄາລວມ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ເງິນທີ່ໄດ້ຮັບ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(replaceString)}',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);
                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ເງິນທອນ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(moneychange)} ',
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
                                        await SunmiPrinter
                                            .submitTransactionPrint();
                                        await SunmiPrinter
                                            .exitTransactionPrint();
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
                                                width:  60.w,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.BASE_COLOR,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ຕົກລົງ",
                                              style: TextStyle(
                                                fontFamily: 'Phetsarath-OT',
                                                fontSize: 16.sp,
                                                color: AppTheme.WHITE_COLOR
                                              ),),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    );
                                      }
                                      await Future.delayed(
                                          Duration(seconds: 2));

                                      await context
                                          .read<UpdateTableProvider>()
                                          .updateTableProvider(
                                              context,
                                              tableid1,
                                              tablename1,
                                              areaid1,
                                              areaname1);
                                      String idarea =
                                          context.read<AreaProvider>().idarea;
                                      await context
                                          .read<AreaProvider>()
                                          .callTable(context, idarea);

                                      await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage()),
                                          (route) => false);
                                    }: () async {
                                      String? areaname1 =
                                          await CountPre().getArea();
                                      String? tablename1 =
                                          await CountPre().getTableName();
                                      String? tableid1 =
                                          await CountPre().getTableId();

                                      String? areaid1 =
                                          await CountPre().getAreaId();
                                      String? billNo =
                                          await CountPre().getBillNo();
                                      int total = 0;

                                      try {
                                        await SunmiPrinter
                                            .startTransactionPrint();
                                        await SunmiPrinter.printText('ໃບບິນ',
                                            style: SunmiStyle(
                                                align: SunmiPrintAlign.CENTER,
                                                bold: true,
                                                fontSize: SunmiFontSize.LG));
                                        await SunmiPrinter.line();

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ໃບບິນເລກທີ', width: 6),
                                          ColumnMaker(
                                              text: '$billNo',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ວັນເວລາ', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())}',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(text: 'ຊັ້ນ', width: 6),
                                          ColumnMaker(
                                              text: '$areaname1',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(text: 'ເລກໂຕະ', width: 6),
                                          ColumnMaker(
                                              text: '$tablename1',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.line();
                                        await SunmiPrinter.printText(
                                            'ລາຍການອາຫານ',
                                            style: SunmiStyle(
                                                align: SunmiPrintAlign.CENTER,
                                                bold: true,
                                                fontSize: SunmiFontSize.MD));

                                        for (var j in context
                                            .read<GetOrderTableProvider>()
                                            .listOrderTable
                                            .first
                                            .order!) {
                                          for (var d in j!.product!) {
                                            String size = setSize(d!.size!);
                                            int sum = 0;

                                            int amount = d.amount!;
                                            int pricesale = int.parse(
                                                d.pricesale.toString());
                                            sum = pricesale * amount;
                                            total += sum;

                                            await SunmiPrinter.printRow(cols: [
                                              ColumnMaker(
                                                  text: '${d.name}', width: 6),
                                              ColumnMaker(
                                                  text:
                                                      '${d.amount} $size ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(d.pricesale)}',
                                                  width: 6,
                                                  align: SunmiPrintAlign.RIGHT),
                                            ]);
                                          }
                                        }

                                        await SunmiPrinter.line();
                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ລາຄາລວມ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);

                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ເງິນທີ່ໄດ້ຮັບ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(replaceString)}',
                                              width: 6,
                                              align: SunmiPrintAlign.RIGHT),
                                        ]);
                                        await SunmiPrinter.printRow(cols: [
                                          ColumnMaker(
                                              text: 'ເງິນທອນ:', width: 6),
                                          ColumnMaker(
                                              text:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(moneychange)} ',
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
                                        await SunmiPrinter
                                            .submitTransactionPrint();
                                        await SunmiPrinter
                                            .exitTransactionPrint();
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
                                                width:  60.w,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.BASE_COLOR,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ຕົກລົງ",
                                              style: TextStyle(
                                                fontFamily: 'Phetsarath-OT',
                                                fontSize: 16.sp,
                                                color: AppTheme.WHITE_COLOR
                                              ),),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    );
                                      }
                                      await Future.delayed(
                                          Duration(seconds: 2));

                                      await context
                                          .read<UpdateTableProvider>()
                                          .updateTableProvider(
                                              context,
                                              tableid1,
                                              tablename1,
                                              areaid1,
                                              areaname1);
                                      String idarea =
                                          context.read<AreaProvider>().idarea;
                                      await context
                                          .read<AreaProvider>()
                                          .callTable(context, idarea);

                                      await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage()),
                                          (route) => false);
                                    },
                              child: Text(
                                "ພິມໃບບິນ",
                                style: TextStyle(
                                    color: AppTheme.WHITE_COLOR,
                                    fontFamily: 'Phetsarath-OT',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              );
            });
      }
    } catch (e) {
      return showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              insetAnimationDuration: const Duration(milliseconds: 5),
              insetAnimationCurve: Curves.bounceOut,
              child: SizedBox(
                height: 200.h,
                width: 100.w,
                child: Center(
                    child: Column(
                  children: [
                    Image.asset(
                      ERPImages.iconerror,
                      height: 104.h,
                      width: 104.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "ກາລຸນາລອງໃໝ່ອີກຄັ້ງ",
                      style: TextStyle(
                          fontSize: 18.sp, color: AppTheme.BASE_COLOR),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40.h,
                          width: 60.w,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("ຕົກລົງ"),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
              ),
            );
          });
    }

    isload = false;
    notifyListeners();
  }
}
