// ignore_for_file: sized_box_for_whitespace

import 'package:erp_pos/bussiness%20logic/authentication.dart';
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
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
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
    return Scaffold(
      backgroundColor: AppTheme.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.WHITE_COLOR,
        title: Text(
          "ສະຖານະປັດຈຸບັນ",
          style: TextStyle(
            fontFamily: "Phetsarath-OT",
            color: AppTheme.BASE_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Mystyle().showDialogSignOut(context);
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isWitch == false
                    ? Text(
                        "ປິດຮ້ານ",
                        style: TextStyle(
                          fontFamily: "Phetsarath-OT",
                          fontSize: 20.sp,
                          color: AppTheme.RED_COLOR,
                        ),
                      )
                    : Text(
                        "ເປີດຮ້ານດຳເນີນການ",
                        style: TextStyle(
                          fontFamily: "Phetsarath-OT",
                          fontSize: 20.sp,
                          color: AppTheme.GREEN_COLOR,
                        ),
                      ),
                Switch(
                  activeColor: AppTheme.GREEN_COLOR,
                  value: isWitch,
                  onChanged: (vale) {
                    if (isWitch == false) {
                      setState(() {
                        isWitch = vale;
                        print("value:$vale");
                        Mystyle().dialogOpen(context);
                      });
                    } else {
                      setState(() async {
                        isWitch = vale;
                        Mystyle().dialogOff(context);
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool(CountPre().prefshift, vale);
                      });
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(formatDate)],
            ),
            SizedBox(
              height: 7.h,
            ),
            isWitch == true
                ? Expanded(
                    child: Column(
                      children: [
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
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(child: ListViewTable()),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text(
                      "ກາລຸນາເປີດກະດ່ວນ",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
