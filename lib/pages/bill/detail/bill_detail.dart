// ignore_for_file: unused_import

import 'package:badges/badges.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/bill/detail/body_detail_bill.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/widget/bottombar_of_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillDetail extends StatelessWidget {
  const BillDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ເລກໂຕະ 000",
          style: TextStyle(
            color: AppTheme.BASE_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const BottomBarOfBill(),
      body: const BodyDetailBill()
    );
  }
}
