import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/bill/tabbarview.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class Bill extends StatelessWidget {
  const Bill({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.WHITE_COLOR,
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title:Container(
          width: 150.w,
          height: 28.h,
          child: Marquee(
            blankSpace: 50,
            velocity: 150,
            pauseAfterRound: Duration(seconds: 2),
            text: 'ປະຫວັດໃບບິນ',
            style: TextStyle(
              fontFamily: "Phetsarath-OT",
              color: AppTheme.BASE_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 21.sp
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ))
        ],
      ),
      body: Consumer<SwitchProvider>(
        builder: (context, value, child) {
          return !value.switchchang
              ? Center(
                  child: Text(
                  "ກະລຸນາເປີດກະກ່ອນ",
                  style: TextStyle(
                      fontFamily: 'Phetsarath-OT',
                      fontSize: 16.sp,
                      color: Colors.grey),
                ))
              : const BillBody();
        },
      ),
    );
  }
}
