// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getsesion/get_sessoin_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/login/login.dart';
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
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/services/getsession/get_sesion.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int? status;
  bool switcstatus = false;

  @override
  void initState() {
    getsessionservice().then(
      (value) {
        if (value != null) {
          context.read<SwitchProvider>().changSwitch(true);
        } else {
          context.read<SwitchProvider>().changSwitch(false);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.WHITE_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.WHITE_COLOR,
        title: Container(
          width: 150.w,
          height: 28.h,
          child: Marquee(
            blankSpace: 50,
            velocity: 150,
            pauseAfterRound: Duration(seconds: 2),
            text: 'ສະຖານະປັດຈຸບັນ',
            style: TextStyle(
                fontFamily: "Phetsarath-OT",
                color: AppTheme.BASE_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 21.sp),
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchTable()));

          //   },
          //   icon: const Icon(
          //     Icons.search_sharp,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              Mystyle().showDialogSignOut(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Consumer<SwitchProvider>(
              builder: ((context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    switcstatus
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
                    CupertinoSwitch(
                        value: value.switchchang,
                        onChanged: ((val) {
                          if (value.switchchang) {
                            Mystyle().dialogOff(context);
                          } else {
                            Mystyle().dialogOpen(context);
                          }
                        }))
                  ],
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formatDate,
                ),
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            !isWitch
                ? Expanded(
                    child: ListViewTable(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text(
                      "ກາລຸນາເປີດກະກ່ອນ",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Phetsarath-OT',
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
