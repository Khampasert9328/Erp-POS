import 'package:badges/badges.dart';
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/pages/order/order.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailOrderTable extends StatefulWidget {
  String tablename;
  GetTable data;
  String id;
  String areaname;

  DetailOrderTable({
    super.key,
    required this.tablename,
    required this.data,
    required this.id,
    required this.areaname,
  });

  @override
  State<DetailOrderTable> createState() => _DetailOrderTableState();
}

class _DetailOrderTableState extends State<DetailOrderTable> {
  List<Product>? data;
  @override
  PrinterStatus? _printerStatus;
  PrinterMode? _printerMode;
  bool isload = false;

  @override
  void initState() {
    super.initState();
    context
        .read<GetOrderTableProvider>()
        .getordertableprovider(context, widget.data.id!);
    _bindingPrinter().then((bool isBind) async => {
          if (isBind)
            {
              _getPrinterStatus(),
              _printerMode = await _getPrinterMode(),
            }
        });
  }

  /// must binding ur printer at first init in app
  Future<bool> _bindingPrinter() async {
    final bool result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  /// you can get printer status
  Future<void> _getPrinterStatus() async {
    final PrinterStatus result = await SunmiPrinter.getPrinterStatus();
    setState(() {
      _printerStatus = result;
    });
  }

  Future<PrinterMode> _getPrinterMode() async {
    final PrinterMode mode = await SunmiPrinter.getPrinterMode();
    return mode;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.WHITE_COLOR,
          elevation: 0,
          title: Text(
            "ລາຍການອໍເດີ ${widget.tablename}",
            style: TextStyle(
              fontFamily: 'Phetsarath-OT',
              color: AppTheme.BASE_COLOR,
            ),
          ),
        ),
        bottomNavigationBar: Consumer<GetOrderTableProvider>(
          builder: ((context, model, _) {
            if (model.isloading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (model.orderTableModels!.order == null) {
                return Center(
                  child: Text("ບໍ່ມີຂໍ້ມູນ"),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.orderTableModels!.order!.length,
                    itemBuilder: ((context, index) {
                      data = model.orderTableModels!.order![index].product!;
                      int sum = 0;
                      int total = 0;
                      for (var data in data!) {
                        int pricesale = int.parse(data.pricesale.toString());
                        int? amount = data.amount;

                        sum = pricesale * amount!;
                        total += sum;
                      }
                      return Container(
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
                                          "${data!.length}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppTheme.BASE_COLOR,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => PayMentMethod(
                                                  tatal: total,
                                                  data: model.orderTableModels!
                                                      .order![index].product,
                                                  datatable: widget.data,
                                                ),
                                              ),
                                            );
                                          },
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
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? billNo =
                                            await CountPre().getBillNo();
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
                                                    '${DateFormat("yyy-MM-dd HH:mm").format(DateTime.now())}',
                                                width: 6,
                                                align: SunmiPrintAlign.RIGHT),
                                          ]);

                                          await SunmiPrinter.printRow(cols: [
                                            ColumnMaker(
                                                text: 'ເລກໂຕະ', width: 6),
                                            ColumnMaker(
                                                text: '',
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

                                          for (var i in data!) {
                                            String size = setSize(i.size!);
                                            await SunmiPrinter.printRow(cols: [
                                              ColumnMaker(
                                                  text: '${i.name}', width: 6),
                                              ColumnMaker(
                                                  text:
                                                      '${i.amount} $size ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(i.pricesale)}',
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
                                                    '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)}',
                                                width: 6,
                                                align: SunmiPrintAlign.RIGHT),
                                          ]);

                                          await SunmiPrinter.line();

                                          await SunmiPrinter.printText(
                                              'ຂໍຂອບໃຈ',
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
                                          print("error:$e");
                                        }
                                      },
                                      child: Container(
                                        height: 60.h,
                                        width: 170.w,
                                        decoration: BoxDecoration(
                                            color: AppTheme.BASE_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppTheme.BASE_COLOR,
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              ERPImages.printbill,
                                              color: AppTheme.WHITE_COLOR,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Center(
                                              child: Text(
                                                "ພິມໃບບິນ",
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: AppTheme.WHITE_COLOR,
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
                      );
                    }));
              }
            }
          }),
        ),
        body: Consumer<GetOrderTableProvider>(
          builder: ((context, model, _) {
            if (model.isloading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (model.orderTableModels!.order == null) {
                return Center(
                  child: Text("ບໍ່ມີຂໍ້ມູນ"),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.orderTableModels!.order!.length,
                    itemBuilder: ((context, index) {
                      data = model.orderTableModels!.order![index].product!;
                      return Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => FoodMenu()));
                                  },
                                  child: Container(
                                    height: 35.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppTheme.BASE_COLOR),
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
                                            fontFamily: 'Phetsarath-OT',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
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
                            for (var food in data!)
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${index += 1}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "${food.name}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${setSize(food.size!)}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(food.amount)}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(food.pricesale)}",
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
                      );
                    }));
              }
            }
          }),
        ));
  }
}
