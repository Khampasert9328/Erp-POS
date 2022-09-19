// ignore_for_file: sized_box_for_whitespace

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/pages/table/components/card_item.dart';
import 'package:erp_pos/pages/table/components/dropdown.dart';
import 'package:erp_pos/pages/table/components/dropdown_status.dart';
import 'package:erp_pos/pages/table/components/dummy_data.dart';
import 'package:erp_pos/pages/table/components/listview_table.dart';
import 'package:erp_pos/pages/table/components/models/card_models.dart';
import 'package:erp_pos/pages/table/components/navbar_status.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/pages/table/components/search_table.dart';
import 'package:erp_pos/pages/table/components/textContainer.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/pages/table/components/textdatetime.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableBody extends StatefulWidget {
  const TableBody({Key? key}) : super(key: key);

  @override
  State<TableBody> createState() => _TableBodyState();
}

DateTime nowTime = DateTime.now();
String formatDate = DateFormat('yyy-MM-dd').format(nowTime);

class _TableBodyState extends State<TableBody> {
  bool isWitch = false;
  bool changScreen = true;
  bool isButton = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 30.h, left: 25.w, right: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      changScreen = true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ສະຖານະປັດຈຸບັນ",
                        style: TextStyle(
                          fontFamily: "Phetsarath-OT",
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppTheme.BLACK_COLOR,
                            borderRadius: BorderRadius.circular(5)),
                        height: 5.h,
                        width: 20.w,
                      ),
                      //
                    ],
                  ),
                ),
                // GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         changScreen = false;
                //       });
                //     },
                //     child: Column(
                //       children: [
                //         Text(
                //           "ການຈອງລ່ວງໜ້າ",
                //           style: TextStyle(
                //             fontFamily: "Phetsarath-OT",
                //             color: !changScreen
                //                 ? ERPTheme.BASE_COLOR
                //                 : ERPTheme.GREY_COLOR,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20.sp,
                //           ),
                //         ),
                //         Container(
                //           color: changScreen == false
                //               ? ERPTheme.BLACK_COLOR
                //               : ERPTheme.GREY_COLOR,
                //           height: 2.h,
                //           width: 120.w,
                //         ),
                //       ],
                //     )),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ເປີດຮ້ານດຳເນີນການ",
                      style: TextStyle(
                        fontFamily: "Phetsarath-OT",
                        fontSize: 20.sp,
                        color: AppTheme.GREEN_COLOR,
                      ),
                    ),
                  ],
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formatDate)
                  ],
                ),
                // changScreen == false
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Text(
                //             "ເລືອກວັນ",
                //             style: TextStyle(
                //               fontFamily: "Phetsarath-OT",
                //               fontSize: 15.sp,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           SizedBox(
                //             width: 7.h,
                //           ),
                //           ERPdate()
                //         ],
                //       )
                //     : Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           isWitch == false
                //               ? Text(
                //                   "ປິດຮ້ານ",
                //                   style: TextStyle(
                //                     fontFamily: "Phetsarath-OT",
                //                     fontSize: 20.sp,
                //                     color: ERPTheme.GREEN_COLOR,
                //                   ),
                //                 )
                //               : Text(
                //                   "ເປີດຮ້ານດຳເນີນການ",
                //                   style: TextStyle(
                //                     fontFamily: "Phetsarath-OT",
                //                     fontSize: 20.sp,
                //                     color: ERPTheme.GREEN_COLOR,
                //                   ),
                //                 ),
                // Switch(
                //   activeColor: ERPTheme.GREEN_COLOR,
                //   value: isWitch,
                //   onChanged: (vale) {
                //     if (isWitch == false) {
                //       setState(() {
                //         isWitch = vale;
                //         Mystyle().dialogOpen(context);
                //       });
                //     } else {
                //       setState(() {
                //         isWitch = vale;
                //         Mystyle().dialogOff(context);
                //       });
                //     }
                //   },
                // ),
                //   ],
                // ),
                //changScreen == false
                // ? Text("")
                // : Padding(
                //     padding: EdgeInsets.only(right: 60.sp),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           formatDate,
                //         ),
                //       ],
                //     ),
                //   ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SearchTable(),
                    IconButton(
                      onPressed: () {
                        //todo
                        Mystyle().dialogbuttom(context);
                      },
                      icon: Image.asset(
                        ERPImages.area,
                        width: 21.w,
                        height: 21.h,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //todo
                      },
                      icon: Image.asset(
                        ERPImages.search,
                        width: 21.w,
                        height: 21.h,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 300,
              child: ListViewTable(),
            )
          ],
        ),
      ),
    );
  }
}
