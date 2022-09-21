import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
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

DateTime time = DateTime.now();
final timenow = DateFormat('HH:mm').format(time);


class _PaymentBceloneState extends State<PaymentBcelone> {
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
                  Stack(
                    children: [
                      Container(
                        height: 63.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.RED_COLOR,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "ຊື່ຮ້ານ:",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.WHITE_COLOR,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      "Xaiy",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.WHITE_COLOR,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(context.read<GetFoodMenuProvider>().totalamont)} ກີບ",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.RED_COLOR),
                    ),
                  ),
                  Container(
                    height: 228.h,
                    width: 228.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: AppTheme.RED_COLOR,
                    )),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImage(
                                data: qrData,
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                             
                             
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      timenow,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
