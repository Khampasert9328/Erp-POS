// ignore_for_file: unnecessary_new, unused_import, prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/pages/table/components/textdate.dart';
import 'package:erp_pos/provider/confirmpaymentbybcel/confirmpaymentbybcel_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/generateQR/generate_qr_bcelone_provider.dart';
import 'package:erp_pos/services/generateqrBCEL/generate_qr_bcelone.dart';
import 'package:erp_pos/utils/formattime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentBcelone extends StatefulWidget {
  final tablename;
  final mcid;
  final shopcode;
  List<Product>? data;

   PaymentBcelone(
      {Key? key,
      required this.tablename,
      required this.mcid,
      required this.shopcode, required this.data})
      : super(key: key);

  @override
  State<PaymentBcelone> createState() => _PaymentBceloneState();
}

class _PaymentBceloneState extends State<PaymentBcelone> {
  String qrData = '';
  bool _isloading = true;
  Timer? timer;
  int count = 5;
  int qrduration = 180;
  int _start = 180;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    GenerateQRBCELONE()
        .getGenerateQR(context, widget.mcid, widget.shopcode, widget.data)
        .then((value) {
      setState(() {
        qrData = value;
      });
    });

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
    int sum =0;
    int total =0;
    for(var i in widget.data!){
      int? amout = i.amount;
      int pricesale = int.parse(i.pricesale.toString());
      sum = pricesale * amout!;
      total += sum;

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
                ERPImages.onepay,
                height: 90.h,
                width: 90.w,
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
                            : _isloading
                                ? CircularProgressIndicator(
                                    color: AppTheme.BASE_COLOR,
                                  )
                                : _start <= 0
                                    ? Container(
                                        height: 200.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppTheme.RED_COLOR,
                                          ),
                                        ),
                                        child: Image.asset(
                                            ERPImages.iconerrorbcel),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          color: AppTheme.BASE_COLOR,
                                        )),
                                        child: QrImage(
                                          eyeStyle: QrEyeStyle(
                                              color: AppTheme.BASE_COLOR),
                                          data: qrData,
                                          version: QrVersions.auto,
                                          size: 200.0,
                                        ),
                                      )
                      ],
                    ),
                  ),
                  Text(formatTime(_start)),
                  if (_start <= 0)
                    TextButton(
                      onPressed: () async {
                        await GenerateQRBCELONE()
                            .getGenerateQR(
                                context, widget.mcid, widget.shopcode,widget.data)
                            .then((value) {
                          setState(() {
                            qrData = value;
                            _start = qrduration;
                            startTimer();
                          });
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: AppTheme.RED_COLOR,
                          border: Border.all(color: AppTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          "ຣີເຟສ QR",
                          style: TextStyle(
                              fontFamily: 'Phetsarath-OT',
                              fontSize: 13.sp,
                              color: AppTheme.WHITE_COLOR),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10.h,
                  )
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
