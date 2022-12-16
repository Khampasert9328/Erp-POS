// ignore_for_file: use_build_context_synchronously

import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/paymentcash/paymentcash_service.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/id_table_provider.dart';
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
      BuildContext context, int number, List<Product>? data) async {
    String? billid = await CountPre().getBillId();
    String? sessionid = await CountPre().getSessionId();
    int paymenttype = 0;
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
      _createPaymentCashModels = await createpaymentcash(
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
                              onPressed: () {
                                
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
                              onPressed: () async{


                                 String? billNo =
                                  context.read<SetIdTable>().billNo;
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
                                        builder: (_) => const HomePage()),
                                    (route) => false);
                              } catch (e) {
                                print("error:$e");
                              }
                              context.read<UpdateTableProvider>().updateTableProvider(context);  
                              },
                              child: Text(
                                "ພິມໃບບິນ",
                                style: TextStyle(
                                    color: AppTheme.WHITE_COLOR,
                                    fontFamily: 'Phetsarath-OT',
                                    fontWeight: FontWeight.bold
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

        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        // context.read<GetFoodMenuProvider>().clearKitchenData();
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
