// ignore_for_file: unused_import

import 'package:badges/badges.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/pages/bill/detail/body_detail_bill.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/widget/bottombar_of_bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillDetail extends StatefulWidget {
  List<Product> data;
  String date;
  String tablename;
  int index;
  int status;
  String billid;
  String orderid;
  BillDetail(
      {super.key,
      required this.data,
      required this.date,
      required this.tablename,
      required this.index,
      required this.status,
      required this.billid,
      required this.orderid
      });

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.WHITE_COLOR,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "ເລກໂຕະ ",
            style: TextStyle(
              color: AppTheme.BASE_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: const BottomBarOfBill(),
        body: BodyDetailBill(
          data: widget.data,
          date: widget.date,
          tablename: widget.tablename,
          status: widget.status,
          billid: widget.billid,
          orderid: widget.orderid,
        ));
  }
}
