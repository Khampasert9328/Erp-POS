import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/bill/tabbarview.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          "ໃບບິນ",
          style: TextStyle(
              fontSize: 25.sp,
              color: AppTheme.BASE_COLOR,
              fontWeight: FontWeight.bold),
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
          return value.switchang == false
              ? Center(
                  child: Text(
                  "ກາລຸນາເປີດກະກ່ອນ",
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ))
              : const BillBody();
        },
      ),
    );
  }
}
