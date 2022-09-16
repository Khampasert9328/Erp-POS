import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/paymentmethod_body.dart';
import 'package:flutter/material.dart';

class PayMentMethod extends StatelessWidget {
  final tablename;
  const PayMentMethod({Key? key, required this.tablename}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ERPTheme.WHITE_COLOR,
        elevation: 0,
        centerTitle: true,
        title: Text(
          tablename,
          style: TextStyle(
            color: ERPTheme.BASE_COLOR,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: PaymentBody(tablename: tablename),
    );
  }
}
