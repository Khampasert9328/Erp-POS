// ignore_for_file: unused_import, unnecessary_import, use_build_context_synchronously

import 'package:codecamp_onepay/codecamp_onepay.dart';
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/generateqrBCEL/generate_qr_bcelone.dart';

import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/utils/transaction/transaction.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/set_size.dart';

class GenerateQRBCELONE extends ChangeNotifier {
  String transaction = '';
  String mcid = 'mch5c2f0404102fb';
  String subScribeKey = 'sub-c-91489692-fa26-11e9-be22-ea7c5aada356';
  String uuID = 'BCELBANK';
  int expiredTime = 3; // ຕ້ອງເປັນນາທີ
  String terminalID = '0000';
  String dateTime = '';

  String get getdateTime => dateTime;
  String qrData = '';
  String get getqrData => qrData;
  //String get getShopecode => shopcode;
  //String shopcode = '12345678';

  //ສຳລັບ transaction
  String token =
      '${double.parse("${getTime() - 15 * 60 * 10000000}").toInt()}0000';
  Future<String> getGenerateQR(
      BuildContext context, String mcid, String shopcode, int total) async {
    transaction = token;
    qrData = CodecampOnepay.initQR(
      mcid,
      transaction,
      terminalID,
      1,
      'invoiceID-$transaction',
      "Codecamp-Payment",
      expiredTime,
      closeWhenPaySuccess: false,
    );

    CodecampOnepay.observe(subScribeKey, uuID, mcid, shopcode, (message) async {
      showDialog(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              color: AppTheme.BASE_COLOR,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () async {
                              String? tablename =
                                  await CountPre().getTableName();
                              String? idtable = await CountPre().getTableId();
                              String? idarea = await CountPre().getAreaId();
                              String? areaname = await CountPre().getArea();
                              await context
                                  .read<UpdateTableProvider>()
                                  .updateTableProvider(context, idtable,
                                      tablename, idarea, areaname);
                              await context
                                  .read<AreaProvider>()
                                  .callAPITable(context, idarea!);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => HomePage()),
                                  (route) => false);
                            },
                            child: Text(
                              "ປິດ",
                              style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                color: AppTheme.WHITE_COLOR,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              color: AppTheme.BASE_COLOR,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () async {
                              String? tablename =
                                  await CountPre().getTableName();
                              String? idtable = await CountPre().getTableId();
                              String? idarea = await CountPre().getAreaId();
                              String? areaname = await CountPre().getArea();
                              String? billNo = context.read<SetData>().billNo;
                              int total = 0;

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
                                    .read<GetOrderTableProvider>()
                                    .listOrderTable) {
                                  for (var j in i.order!) {
                                    for (var d in j!.product!) {
                                      String size = setSize(d!.size!);
                                      int sum = 0;

                                      int amount = d.amount!;
                                      int pricesale =
                                          int.parse(d.pricesale.toString());
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
                                }
                                await SunmiPrinter.line();
                                await SunmiPrinter.printRow(cols: [
                                  ColumnMaker(text: 'ລາຄາລວມ:', width: 6),
                                  ColumnMaker(
                                      text:
                                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ',
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
                                await context
                                    .read<UpdateTableProvider>()
                                    .updateTableProvider(context, idtable,
                                        tablename, idarea, areaname);
                                await context
                                    .read<AreaProvider>()
                                    .callAPITable(context, idarea!);
                                await Future.delayed(Duration(seconds: 2));
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomePage()),
                                    (route) => false);
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
                            },
                            child: Text(
                              "ພິມໃບບິນ",
                              style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                color: AppTheme.WHITE_COLOR,
                              ),
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
    });
    notifyListeners();
    return qrData;
  }
}
