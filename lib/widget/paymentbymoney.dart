import 'dart:async';

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/provider/confirmpaymentbybcel/confirmpaymentbybcel_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/generateqrmmoney/generate_qr_mmoney_provider.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/provider/paycash/paymentcash_provider.dart';
import 'package:erp_pos/utils/formattime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentMmoney extends StatefulWidget {
 
  final qrdata;
  final username;
  final walletid;

  String idtable;
  String tablename;
  String id;
  String areaname;
   PaymentMmoney(
      {Key? key,
      
      required this.qrdata,
      required this.username,
      required this.walletid,
     
      required this.id,
      required this.areaname,
      required this.idtable,
      required this.tablename
      })
      : super(key: key);

  @override
  State<PaymentMmoney> createState() => _PaymentMmoneyState();
}

class _PaymentMmoneyState extends State<PaymentMmoney> {
  bool _isloading = true;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _isloading = false;
      });
    });
    Future.delayed(Duration(milliseconds: 500), (() {
      setState(() {
        _isloading = false;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
     int sum = 0;
    int total = 0;
     for (var i in context.read<GetOrderTableProvider>().listOrderTable) {
      for (var d in i.order!) {
        for (var j in d!.product!) {
           int? amout = j!.amount;
      int pricesale = int.parse(j.pricesale.toString());
      sum = pricesale * amout!;
      total += sum;
        }
        
      }
     
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          widget.tablename,
          style: TextStyle(color: AppTheme.BASE_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ERPImages.mmoney,
                height: 63.h,
                width: 63.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "ສະແກນເພື່ອຊຳລະ",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppTheme.BASE_COLOR,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Phetsarath-OT',
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(total)} ກີບ",
                      style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.RED_COLOR),
                    ),
                  ),
                  //ສຳລັບ generate code
                  Container(
                    height: 228.h,
                    width: 228.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.qrdata.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : _isloading
                                ? CircularProgressIndicator(
                                    color: AppTheme.BASE_COLOR,
                                  )
                                : QrImage(
                                        eyeStyle: QrEyeStyle(
                                          color: AppTheme.BASE_COLOR,
                                        ),
                                        data: widget.qrdata,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      ),
                       
                  
                      ],
                    ),
                  ),
                  ///////////////////////////////////////////
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 65.0, left: 65.0),
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppTheme.BASE_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    PaymentCashProvider().createpaymentcashprovider(context, total);
                  },
                  child: Text(
                    "ຢືນຢັນການຊຳລະ",
                    style: TextStyle(
                      color: AppTheme.WHITE_COLOR,
                      fontSize: 16.sp,
                      fontFamily: 'Phetsarath-OT',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
