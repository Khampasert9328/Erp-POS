// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:badges/badges.dart' as Badges;
import 'package:devla_sunmi/flutter_sunmi_printer.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/order/order.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/utils/loading.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/paymentmethod.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateMoney extends StatefulWidget {
  String tablename;
  CalculateMoney({Key? key, required this.tablename}) : super(key: key);

  @override
  State<CalculateMoney> createState() => _CalculateMoneyState();
}

class _CalculateMoneyState extends State<CalculateMoney> {
  @override
  PrinterStatus? _printerStatus;
  PrinterMode? _printerMode;
  @override
  void initState() {
    _bindingPrinter().then((bool isBind) async => {
          if (isBind)
            {
              _getPrinterStatus(),
              _printerMode = await _getPrinterMode(),
            }
        });
    super.initState();
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
    return Consumer<GetFoodMenuProvider>(
      builder: ((context, value, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppTheme.WHITE_COLOR,
              elevation: 0,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: (() async {
                      await UpdateTableProvider().updatetableStatus(context);
                    }),
                    child: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "ໂຕະ ${widget.tablename}",
                      style: TextStyle(
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 145.h,
              width: double.infinity,
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
                                  "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ",
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
                                  UpdateTableProvider()
                                      .updatetableStatus(context);
                                },
                                child: Text(
                                  "ປິດ",
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
                              String? getzone = await CountPre().getArea();
                              String? billNo = await CountPre().getBillNo();

                              if (context
                                  .read<GetFoodMenuProvider>()
                                  .getFoodMenuModel
                                  .isEmpty) {
                                Mystyle().showDialogCheckData(
                                    context, "ບໍ່ມີຂໍ້ມູນໃບບິນ");
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: ShowLoading(
                                        title: "ກຳລັງພິມໃບບິນ...",
                                      ),
                                    );
                                  },
                                );
                                await Future.delayed(Duration(seconds: 5));
                                try {
                                  Navigator.of(context).pop();
                                  await SunmiPrinter.startTransactionPrint();
                                  await SunmiPrinter.printText('ໃບບິນຫ້ອງຄົວ',
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
                                        text: '${getzone ?? "none"}',
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

                                  for (var i in context
                                      .read<GetFoodMenuProvider>()
                                      .getFoodMenuModel) {
                                    String size = setSize(i.size);
                                    await SunmiPrinter.printRow(cols: [
                                      ColumnMaker(
                                          text: '${i.data.name}', width: 6),
                                      ColumnMaker(
                                          text:
                                              '${i.amount}x $size  ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(i.specialprice)}',
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
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "ຕົກລົງ",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Phetsarath-OT',
                                                      fontSize: 16.sp,
                                                      color:
                                                          AppTheme.WHITE_COLOR),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                }
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
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8, left: 8),
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
                                        "ພິມບິນຫ້ອງຄົວ",
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
                          context
                              .read<ClickTableProvider>()
                              .firsOrderMoreTB(true);
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
                                  fontFamily: 'Phetsarath-OT',
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
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Phetsarath-OT',
                        ),
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
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Phetsarath-OT',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "ລາຍການ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppTheme.WHITE_COLOR,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Phetsarath-OT',
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "ຂະໜາດ",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
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
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 14.sp,
                                color: AppTheme.WHITE_COLOR,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "ລາຄາ",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
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
                            int numsize = value.getFoodMenuModel[index].size;
                            String? size = setSize(numsize);
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
                                  child: Center(
                                    child: Text("$size"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                        "${value.getFoodMenuModel[index].amount}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.getFoodMenuModel[index].specialprice)}"),
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
      }),
    );
  }
}
