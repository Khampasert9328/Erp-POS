import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/widget/paymentmethod_body.dart';
import 'package:flutter/material.dart';

class PayMentMethod extends StatelessWidget {
  GetTable datatable;
  String id;
  String areaname;
  String tablename;
  List<Product>? data;
  int tatal;
  PayMentMethod(
      {Key? key,
      required this.tablename,
      required this.data,
      required this.datatable,
      required this.id,
      required this.areaname,
      required this.tatal
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        centerTitle: true,
        title: Text(
          tablename,
          style: TextStyle(
            color: AppTheme.BASE_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PaymentBody(
        tatal: tatal,
        tablename: tablename,
        data: data,
        datatable: datatable,
        id: id,
        areaname: areaname,
      ),
    );
  }
}
