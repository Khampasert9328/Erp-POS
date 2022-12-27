// ignore_for_file: use_build_context_synchronously

import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/generateqrmmoney/generateqrmmoney.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/services/gerneratem-money/generate_m_money.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentbymoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GenerateQrMmoneyProvider extends ChangeNotifier {
  GenerateQrMmoney? _generateQrMmoney;
  GenerateQrMmoney? get generateQrMmoney => _generateQrMmoney;

  Future<void> getqrmmoney(
      BuildContext context, String username, String walletid, List<Product>? data, String idtable, String tablename, String idarea, String area) async {
  
    _generateQrMmoney = await generatemmneyservice(context, username, walletid);

    if (_generateQrMmoney != null) {
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
                            onPressed: () {
                              Navigator.pop(context);
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
                              String? billNo =
                                  context.read<SetData>().billNo;
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

                                for (var i in data!) {
                                  String size = setSize(i.size!);
                                  int sum = 0;

                                  int amount = i.amount!;
                                  int pricesale =
                                      int.parse(i.pricesale.toString());
                                  sum = pricesale * amount;
                                  total += sum;

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

                                await Future.delayed(Duration(seconds: 2));
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomePage()),
                                    (route) => false);
                              } catch (e) {
                                print("error:$e");
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentMmoney(
            areaname: area,
            id: idarea,
            data: data,
            qrdata: _generateQrMmoney!.qrcodeStr,
           idtable: idtable,
           tablename: tablename,
            username: username,
            walletid: walletid,
          ),
        ),
      );
    }
    notifyListeners();
  }
}
