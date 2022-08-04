// ignore_for_file: sized_box_for_whitespace

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
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
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TableBody extends StatefulWidget {
  const TableBody({Key? key}) : super(key: key);

  @override
  State<TableBody> createState() => _TableBodyState();
}

DateTime nowTime = DateTime.now();
String formatDate = DateFormat('yyy-MM-dd HH:mm:ss').format(nowTime);

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
                  child: Text(
                    "ສະຖານະປັດຈຸບັນ",
                    style: TextStyle(
                      fontFamily: "Phetsarath-OT",
                      color: !changScreen
                          ? ERPTheme.GREY_COLOR
                          : ERPTheme.BASE_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      changScreen = false;
                    });
                  },
                  child: Text(
                    "ການຈອງລ່ວງໜ້າ",
                    style: TextStyle(
                      fontFamily: "Phetsarath-OT",
                      color: !changScreen
                          ? ERPTheme.BASE_COLOR
                          : ERPTheme.GREY_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                changScreen == false
                    ? Row(
                        children: [
                          Text(
                            "ເລືອກວັນ",
                            style: TextStyle(
                              fontFamily: "Phetsarath-OT",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 12.h,
                          ),
                          ERPdate()
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isWitch == false
                              ? Text(
                                  "ປິດຮ້ານ",
                                  style: TextStyle(
                                    fontFamily: "Phetsarath-OT",
                                    fontSize: 17.sp,
                                    color: ERPTheme.GREEN_COLOR,
                                  ),
                                )
                              : Text(
                                  "ເປີດຮ້ານດຳເນີນການ",
                                  style: TextStyle(
                                    fontFamily: "Phetsarath-OT",
                                    fontSize: 17.sp,
                                    color: ERPTheme.GREEN_COLOR,
                                  ),
                                ),
                          Switch(
                            activeColor: ERPTheme.GREEN_COLOR,
                            value: isWitch,
                            onChanged: (vale) {
                              if (isWitch == false) {
                                setState(() {
                                  isWitch = vale;
                                  Mystyle().dialogOpen(context);
                                });
                              } else {
                                setState(() {
                                  isWitch = vale;
                                  Mystyle().dialogOff(context);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                changScreen == false
                    ? Text("")
                    : Padding(
                        padding: EdgeInsets.only(right: 9.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("ອັບເດັດລ່າສຸດ : " + formatDate,
                                style: TextStyle(
                                    fontFamily: "Phetsarath-OT",
                                    fontSize: 11.sp,
                                    color: ERPTheme.BASE_COLOR,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 11.h,
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
                        POSImages.area,
                        width: 19.w,
                        height: 19.h,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //todo
                      },
                      icon: Image.asset(
                        POSImages.search,
                        width: 19.w,
                        height: 19.h,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: ListViewTable(),
                ),
                SizedBox(
                  height: 18.h,
                ),
                changScreen == false
                    ? const NavBarStatusBooking()
                    : NavBarStatus(),
              ],
            ),
            GridView.count(
              childAspectRatio: (1 / .4),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              children: DummyData.map(
                (CardModels) => CardItem(
                  title: CardModels.title,
                  color: changScreen == false
                      ? ERPTheme.BLUE_COLOR
                      : CardModels.color,
                  id: CardModels.id,
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
