// ignore_for_file: unnecessary_new, unused_import, prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/confirmpaymentbybcel/confirmpaymentbybcel_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/generateQR/generate_qr_bcelone_provider.dart';
import 'package:erp_pos/services/generateqrBCEL/generate_qr_bcelone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentBcelone extends StatefulWidget {
  final tablename;
  const PaymentBcelone({Key? key, required this.tablename}) : super(key: key);

  @override
  State<PaymentBcelone> createState() => _PaymentBceloneState();
}

class _PaymentBceloneState extends State<PaymentBcelone> {
  String qrData = '';
  @override
  void initState() {
    super.initState();
    GenerateQRBCELONE().getGenerateQR(context).then((value) {
      setState(() {
        qrData = value;
      });
    });
  }

  bool chang = false;
  @override
  Widget build(BuildContext context) {
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
                ERPImages.bcelone,
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
                      "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ",
                      style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.RED_COLOR),
                    ),
                  ),
                  Container(
                    height: 228.h,
                    width: 228.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        qrData.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : QrImage(
                                data: qrData,
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextButton(
                    onPressed: () async {
                      await GenerateQRBCELONE()
                          .getGenerateQR(context)
                          .then((value) {
                        setState(() {
                          qrData = value;
                        });
                      });
                    },
                    child: chang == false ? Text("") : Text("data"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
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
                    ConfirmPaymentByBCELONE().confirmbcelone(context);
                  },
                  child: Text(
                    "ຢືນຢິນການຊຳລະ",
                    style: TextStyle(
                        color: AppTheme.WHITE_COLOR,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
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
