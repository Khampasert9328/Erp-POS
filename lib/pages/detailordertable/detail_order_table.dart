import 'package:badges/badges.dart' as Badges;
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_body.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/pages/order/order.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
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
  @override
  PrinterStatus? _printerStatus;
  PrinterMode? _printerMode;
  bool isload = false;

  @override
  void initState() {
    super.initState();
    context.read<GetOrderTableProvider>().getordertableprovider(context);
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
    Product product;
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
      bottomNavigationBar: Container(
        height: 145.h,
        child: BottomAppBar(
          notchMargin: 5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<GetOrderTableProvider>(
                builder: (context, value, child) {
                  int sum = 0;
                  int total = 0;
                  int? amount;
                  int? pricesale;
                  for (var food in value.listOrderTable) {
                    if (food.order!.first!.tableid == widget.data.id) {
                      CountPre().setBillDetail(food.order!.first!.billid!);
                      for (var i in food.order!) {
                        CountPre().setOrderId(i!.id!);

                        for (var j in i.product!) {
                          amount = j!.amount!;
                          pricesale = j.pricesale!;
                          sum = pricesale * amount;
                          total += sum;
                        }
                      }

                      return Column(
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
                                    "${food.order!.first!.product!.length}",
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      context
                                          .read<SetData>()
                                          .setCheckOrderToBlackhome(false);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PayMentMethod(
                                            tablename: widget.tablename,
                                            tatal: total,
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
                                          text: '${widget.tablename}',
                                          width: 6,
                                          align: SunmiPrintAlign.RIGHT),
                                    ]);

                                    await SunmiPrinter.line();
                                    await SunmiPrinter.printText('ລາຍການອາຫານ',
                                        style: SunmiStyle(
                                            align: SunmiPrintAlign.CENTER,
                                            bold: true,
                                            fontSize: SunmiFontSize.MD));
                                    for (var i
                                        in value.listOrderTable.first.order!) {
                                      if (i!.tableid == widget.data.id) {
                                        for (var j in i.product!) {
                                          String size = setSize(j!.size!);
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
                                      }
                                    }

                                    await SunmiPrinter.line();
                                    await SunmiPrinter.printRow(cols: [
                                      ColumnMaker(text: 'ລາຄາລວມ:', width: 6),
                                      ColumnMaker(
                                          text:
                                              '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ກີບ',
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
                                                        BorderRadius.circular(
                                                            5)),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "ຕົກລົງ",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Phetsarath-OT',
                                                        fontSize: 16.sp,
                                                        color: AppTheme
                                                            .WHITE_COLOR),
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
                                  width: 170.w,
                                  decoration: BoxDecoration(
                                      color: AppTheme.BASE_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppTheme.BASE_COLOR,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      );
                    }
                  }
                  return Container();
                },
              )),
        ),
      ),
      body: Consumer<GetOrderTableProvider>(
        builder: ((context, model, _) {
          if (model.isloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (model.listOrderTable == null) {
              return const Center(
                child: Text("ບໍ່ມີຂໍ້ມູນ"),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                context
                                    .read<ClickTableProvider>()
                                    .clickTableProvider(false);
                                context
                                    .read<ClickTableProvider>()
                                    .firsOrderMoreTB(true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FoodMenuBody(
                                      tablename: widget.tablename,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 35.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppTheme.BASE_COLOR),
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
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: model
                              .orderTableModels!.order!.first!.product!.length,
                          itemBuilder: ((context, index) {
                            product = model.orderTableModels!.order!.first!
                                .product![index]!;
                            if (model.isloading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (model.orderTableModels!.order!.first!
                                      .product ==
                                  null) {
                                return const Center(
                                  child: Text("ບໍ່ມີຂໍ້ມູນ"),
                                );
                              } else {
                                return SingleChildScrollView(
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
                                          "${product.name}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${setSize(product.size!)}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${product.amount}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(product.pricesale)} ",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }
        }),
      ),
    );
  }
}
