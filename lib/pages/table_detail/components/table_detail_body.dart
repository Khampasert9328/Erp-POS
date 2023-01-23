// ignore_for_file: sort_child_properties_last

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/food_menu/components/food_menu_body.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/food_menu_card.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';

class TableDetail extends StatefulWidget {
  GetTable data;
  Order? orderTable;
  TableDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TableDetail> createState() => _TableDetailState();
}

class _TableDetailState extends State<TableDetail> {
  bool isWitch = true;
  bool cupertinoswitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          "${widget.data.name}",
          style: TextStyle(color: AppTheme.BLACK_COLOR),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isWitch == false
            ? Text("")
            : Container(
                height: 49.h,
                width: double.infinity,
                child: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    context.read<ClickTableProvider>().firsOrderMoreTB(false);
                    bool clicktable = true;
                    CountPre().setClickTable(clicktable);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoodMenuBody(),
                      ),
                    );
                  },
                  label: Text(
                    "ສັ່ງອາຫານ",
                    style: TextStyle(
                        fontFamily: 'Phetsarath-OT',
                        color: AppTheme.WHITE_COLOR,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),
                  backgroundColor: AppTheme.BASE_COLOR,
                  elevation: 5,
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //    cupertinoswitch? Text(
            //       "ເປິດໂຕະ",
            //       style: TextStyle(
            //         fontFamily: 'Phetsarath-OT',
            //         fontSize: 18.sp
            //       ),
            //     ):Text(
            //       "ປິດໂຕະ",
            //       style: TextStyle(
            //         fontFamily: 'Phetsarath-OT',
            //         fontSize: 18.sp
            //       ),
            //     ),
            //     CupertinoSwitch(
            //         value: cupertinoswitch,
            //         onChanged: ((value) {
            //           setState(() {
            //             cupertinoswitch = value;
            //           });
            //         }))
            //   ],
            // ),
            SizedBox(
              height: 25.h,
            ),
            Column(
              children: [
                Center(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.BASE_COLOR),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.BASE_COLOR),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 70.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.BASE_COLOR),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              widget.data.name!,
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 40.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.BASE_COLOR),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        height: 10.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.BASE_COLOR),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ເລກໂຕະ",
                      style: TextStyle(
                        fontFamily: 'Phetsarath-OT',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.data.name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ໂຊນ ຫຼື ພື້ນທີ່",
                      style: TextStyle(
                        fontFamily: 'Phetsarath-OT',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.data.tablearea!.area!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
